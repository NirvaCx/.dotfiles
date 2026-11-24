# the check is bash's default value
PS1='[\[\e[2m\]\w\[\e[0m\]]\n\[\e[1m\][\u\[\e[0;93m\]@\H\[\e[0;1m\]]\[\e[0m\] \[\e[1m\]\$\[\e[0m\] '

# command colouring
alias diff='diff --color=auto'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
export LESS='--RAW-CONTROL-CHARS --use-color -Dd+r -Du+b'

case ${TERM} in
  Eterm*|alacritty*|aterm*|foot*|gnome*|konsole*|kterm*|putty*|rxvt*|tmux*|xterm*|kitty*)
    PROMPT_COMMAND+=('printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"')
    ;;
  screen*)
    PROMPT_COMMAND+=('printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"')
    ;;
esac
. "$HOME/.cargo/env"
