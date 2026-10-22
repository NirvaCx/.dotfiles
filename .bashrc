[[ $- != *i* ]] && return
export PATH=$HOME/.local/bin:$PATH
export VISUAL="helix"
export EDITOR="helix"
alias diff='diff --color=auto'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
export LESS='--RAW-CONTROL-CHARS --use-color -Dd+r -Du+b'
# export LS_COLORS="*.c=00;32:*.cpp=00;96:*exe=01;35:ex=01;35:*.hpp=00;34:*.py=00;34"

# echo ''
# neofetch --color_blocks off

PROMPT_COMMAND=__prompt_command # Function to generate PS1 after CMDs

__prompt_command() {
  local EXIT="$?" # This needs to be first
  PS1=""

  local RCol='\[\e[0m\]'

  local Red='\[\e[38;5;198m\]'
  local Gre='\[\e[38;5;189m\]'
  local BYel='\[\e[38;5;245m\]'
  local BBlu='\[\e[1;34m\]'
  local Pur='\[\e[0;35m\]'

  # SHELL_MOMMYS_LITTLE - what to call you~ (default: "girl")
  # SHELL_MOMMYS_PRONOUNS - what pronouns mommy will use for themself~ (default: "her")
  # SHELL_MOMMYS_ROLES - what role mommy will have~ (default "mommy")

  COLORS_LIGHT_PINK='\e[38;5;125m'
  COLORS_LIGHT_BLUE='\e[38;5;130m'
  COLORS_FAINT='\e[2m'
  COLORS_RESET='\e[0m'

  DEF_WORDS_LITTLE="girl/strawberry/cookie/ray of sunshine"
  DEF_WORDS_PRONOUNS="her"
  DEF_WORDS_ROLES="mommy"
  DEF_MOMMY_COLOR="${COLORS_LIGHT_BLUE}"
  DEF_ONLY_NEGATIVE="false"

  NEGATIVE_RESPONSES="do you need MOMMYS_ROLE's help~? ❤️
Don't give up, my love~ ❤️
Don't worry, MOMMYS_ROLE is here to help you~ ❤️
I believe in you, my sweet AFFECTIONATE_TERM~ ❤️
It's okay to make mistakes, my dear~ ❤️
just a little further, sweetie~ ❤️
Let's try again together, okay~? ❤️
MOMMYS_ROLE believes in you, and knows you can overcome this~ ❤️
MOMMYS_ROLE believes in you~ ❤️
MOMMYS_ROLE is always here for you, no matter what~ ❤️
MOMMYS_ROLE is here to help you through it~ ❤️
MOMMYS_ROLE is proud of you for trying, no matter what the outcome~ ❤️
MOMMYS_ROLE knows it's tough, but you can do it~ ❤️
MOMMYS_ROLE knows MOMMYS_PRONOUN little AFFECTIONATE_TERM can do better~ ❤️
MOMMYS_ROLE knows you can do it, even if it's tough~ ❤️
MOMMYS_ROLE knows you're feeling down, but you'll get through it~ ❤️
MOMMYS_ROLE knows you're trying your best~ ❤️
MOMMYS_ROLE loves you, and is here to support you~ ❤️
MOMMYS_ROLE still loves you no matter what~ ❤️
You're doing your best, and that's all that matters to MOMMYS_ROLE~ ❤️
MOMMYS_ROLE is always here to encourage you~ ❤️"

  POSITIVE_RESPONSES="*pets your head*
awe, what a good AFFECTIONATE_TERM~\nMOMMYS_ROLE knew you could do it~ ❤️
good AFFECTIONATE_TERM~\nMOMMYS_ROLE's so proud of you~ ❤️
Keep up the good work, my love~ ❤️
MOMMYS_ROLE is proud of the progress you've made~ ❤️
MOMMYS_ROLE is so grateful to have you as MOMMYS_PRONOUN little AFFECTIONATE_TERM~ ❤️
I'm so proud of you, my love~ ❤️
MOMMYS_ROLE is so proud of you~ ❤️
MOMMYS_ROLE loves seeing MOMMYS_PRONOUN little AFFECTIONATE_TERM succeed~ ❤️
MOMMYS_ROLE thinks MOMMYS_PRONOUN little AFFECTIONATE_TERM earned a big hug~ ❤️
that's a good AFFECTIONATE_TERM~ ❤️
you did an amazing job, my dear~ ❤️
you're such a smart cookie~ ❤️"

  # allow for overriding of default words (IF ANY SET)

  if [ -n "$SHELL_MOMMYS_LITTLE" ]; then
    DEF_WORDS_LITTLE="${SHELL_MOMMYS_LITTLE}"
  fi
  if [ -n "$SHELL_MOMMYS_PRONOUNS" ]; then
    DEF_WORDS_PRONOUNS="${SHELL_MOMMYS_PRONOUNS}"
  fi
  if [ -n "$SHELL_MOMMYS_ROLES" ]; then
    DEF_WORDS_ROLES="${SHELL_MOMMYS_ROLES}"
  fi
  if [ -n "$SHELL_MOMMYS_COLOR" ]; then
    DEF_MOMMY_COLOR="${SHELL_MOMMYS_COLOR}"
  fi
  # allow overriding to true
  if [ "$SHELL_MOMMYS_ONLY_NEGATIVE" = "true" ]; then
    DEF_ONLY_NEGATIVE="true"
  fi
  # if the variable is set for positive/negative responses, overwrite it
  if [ -n "$SHELL_MOMMYS_POSITIVE_RESPONSES" ]; then
    POSITIVE_RESPONSES="$SHELL_MOMMYS_POSITIVE_RESPONSES"
  fi
  if [ -n "$SHELL_MOMMYS_NEGATIVE_RESPONSES" ]; then
    NEGATIVE_RESPONSES="$SHELL_MOMMYS_NEGATIVE_RESPONSES"
  fi

  # split a string on forward slashes and return a random element
  pick_word() {
    echo "$1" | tr '/' '\n' | shuf | sed 1q
  }

  pick_response() { # given a response type, pick an entry from the list

    if [ "$1" = "positive" ]; then
      element=$(echo "$POSITIVE_RESPONSES" | shuf | sed 1q)
    elif [ "$1" = "negative" ]; then
      element=$(echo "$NEGATIVE_RESPONSES" | shuf | sed 1q)
    else
      echo "Invalid response type: $1"
      exit 1
    fi

    # Return the selected response
    echo "$element"

  }

  sub_terms() { # given a response, sub in the appropriate terms
    response="$1"
    # pick_word for each term
    affectionate_term="$(pick_word "${DEF_WORDS_LITTLE}")"
    pronoun="$(pick_word "${DEF_WORDS_PRONOUNS}")"
    role="$(pick_word "${DEF_WORDS_ROLES}")"
    # sub in the terms, store in variable
    response="$(echo "$response" | sed "s/AFFECTIONATE_TERM/$affectionate_term/g")"
    response="$(echo "$response" | sed "s/MOMMYS_PRONOUN/$pronoun/g")"
    response="$(echo "$response" | sed "s/MOMMYS_ROLE/$role/g")"
    # we have string literal newlines in the response, so we need to printf it out
    # print faint and colorcode
    echo "${DEF_MOMMY_COLOR}$response${COLORS_RESET}"
  }

  success() {
    (
      # if we're only supposed to show negative responses, return
      if [ "$DEF_ONLY_NEGATIVE" = "true" ]; then
        return 0
      fi
      # pick_response for the response type
      response="$(pick_response "positive")"
      response="$(sub_terms "$response")"
      echo "$response"
    )
    return 0
  }
  failure() {
    (
      response="$(pick_response "negative")"
      response="$(sub_terms "$response")"
      echo "$response"
    )
  }

  # PS1+="${RCol}\n\t "
  PS1+="${BYel}\w\[\e[0m\]\n"

  local disable_mommy=true

  if [ $EXIT != 0 ]; then
    response="$(failure)"
    if [[ $(tty) = /dev/tty* ]] || [[ $disable_mommy = true ]]; then
      response=""
    fi
    PS1+="[${Red}${EXIT}\[\e[0m\]] $response" # Add red if exit code non 0
  else
    response="$(success)"
    if [[ $(tty) = /dev/tty* ]] || [[ $disable_mommy = true ]]; then
      response=""
    fi
    PS1+="$response"
  fi

  PS1+="\[\e[01;95m\]\u\[\e[00;37m\]@\[\e[1;37m\]\h\[\e[0m\] ${Gre}\$\[\e[0m\] "
}

# XDG Base Directory variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export PATH="/home/nirva/.cargo/bin:$PATH"
