alias agi='sudo apt-get install' 
alias agp='sudo apt-get purge'
alias acs='apt-cache search'

if [[ $TERM_PROGRAM == "Apple_Terminal" ]]; then 
    alias ls="ls -G"
    alias ll="ls -alFhG"
else
    alias ls="ls --color=auto"
    alias ll="ls -alFh --color=auto"
fi

alias ping="grc ping"
alias traceroute="grc traceroute"
alias make="grc make"
alias diff="grc diff"
alias cvs="grc cvs"
alias netstat="grc netstat"
alias tail="grc tail"
alias head="grc head"

alias dj="grc python manage.py"

alias pcat="pygmentize -f terminal -g"
