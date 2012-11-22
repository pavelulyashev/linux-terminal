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

alias less="less --RAW-CONTROL-CHARS"

alias dj="python manage.py"

alias pcat="pygmentize -f terminal -g"
alias reload_bash="source ~/.bashrc"
