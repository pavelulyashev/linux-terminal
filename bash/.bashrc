# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# include human-readable colors
[[ -f ~/.bash_colors ]] && . ~/.bash_colors

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
    export TERM='xterm-256color'
else
    export TERM='xterm-color'
fi

if [ $TERM_PROGRAM == "Apple_Terminal" ]; then
    [[ -f `brew --prefix`/etc/bash_completion ]] && . `brew --prefix`/etc/bash_completion
else
    [[ -f /etc/bash_completion ]] && . /etc/bash_completion
fi

# Check if ssh connection is active
function is_ssh {
    if [[ -n $SSH_CLIENT ]]; then echo 1; else echo 0; fi
}

function ssh_greetings {
    echo " ssh `echo $SSH_CLIENT | tr " " "\n" | head -1`"
}

if [[ $EUID -eq 0 ]]; then
    if [ $(is_ssh) -eq 1 ]; then
        export PS1="\[$BGreen\][\t]\[$BWhite\]$(ssh_greetings) \[$BRed\]\u@\h \[$BGreen\]\w\[$Blue\]$(__git_ps1) \[$BRed\]# \[$BPurple\]"
    else
        export PS1="\[$BBlue\][\t] \[$BRed\]\u@\h \[$BBlue\]\w\[$Blue\]$(__git_ps1) \[$BRed\]# \[$BPurple\]"
    fi
else 
    if [ $(is_ssh) -eq 1 ]; then
        export PS1="\[$Green\][\t]\[$BPurple\]$(ssh_greetings) \[$Blue\]\u@\h \[$BGreen\]\w\[$BWhite\]$(__git_ps1) \[$BYellow\]\$ \[$Green\]"
    else
        export PS1="\[$Cyan\][\t] \[$Green\]\u@\h \[$BBlue\]\w\[$BWhite\]$(__git_ps1) \[$BGreen\]\$ \[$Yellow\]"
    fi
fi

#
# Use printf here because echo has no option -e in mac
#trap 'echo -ne "${Color_Off}"' DEBUG
trap 'echo -n `printf "${Color_Off}"`' DEBUG

# colorize man pages

man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;33m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;30m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
            man "$@"
}
export LS_COLORS='no=00;37:fi=00;37:di=01;36:ln=04;36:pi=33:so=01;35:do=01;35:bd=33;01:cd=33;01:or=31;01:su=37:sg=30:tw=30:ow=34:st=37:ex=01;31:*.cmd=01;31:*.exe=01;31:*.com=01;31:*.btm=01;31:*.sh=01;31:*.run=01;31:*.tar=33:*.tgz=33:*.arj=33:*.taz=33:*.lzh=33:*.zip=33:*.z=33:*.Z=33:*.gz=33:*.bz2=33:*.deb=33:*.rpm=33:*.jar=33:*.rar=33:*.jpg=32:*.jpeg=32:*.gif=32:*.bmp=32:*.pbm=32:*.pgm=32:*.ppm=32:*.tga=32:*.xbm=32:*.xpm=32:*.tif=32:*.tiff=32:*.png=32:*.mov=34:*.mpg=34:*.mpeg=34:*.avi=34:*.fli=34:*.flv=34:*.3gp=34:*.mp4=34:*.divx=34:*.gl=32:*.dl=32:*.xcf=32:*.xwd=32:*.flac=35:*.mp3=35:*.mpc=35:*.ogg=35:*.wav=35:*.m3u=35:';
export LESS_TERMCAP_so=$(printf "\e[1;44;30m")

# grep colors for linux
export GREP_COLORS="mt=38;5;0;48;5;191:fn=38;5;147:ln=38;5;178:se=38;5;244:bn=38;5;148"
# grep color for mac
export GREP_COLOR="1;91;43"
export GREP_OPTIONS="--color=auto"

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

