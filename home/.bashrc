# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

maklangfuntion() {

    make "$@" 2>&1 | tee >(GREP_COLORS='mt=00;32' egrep "^(\[ *[0-9]+\%\] )+(Linking |Scanning dependenc(ies|y) |Building |Generating )?.*") \
                         >(GREP_COLORS='mt=00;32' egrep "^(Linking |Scanning dependenc(ies|y) |Building |Generating ).*") \
                         >(egrep -v "(third_party|/linenoise/|\.pb\.).*warning: " | GREP_COLORS='mt=01;35' egrep "warning: " -A 20 -B 20) \
                         >(egrep "error: " -A 10 -B 10) \
                         > ./maklang.log
}

alias maklang=maklangfuntion
alias maktest='workon jormungandr && make test && workon eitri && make docker_test && workon jormungandr'
alias ls="ls --color=auto"
alias ll="ls -la"
alias rm='rm -i'
alias cp='cp -i'
alias remote='rdesktop -K -g 1282x748'
alias st='sublime-text'
alias vi='vim'
alias mv='mv -i'
alias doPurify='valgrind --tool=memcheck -v --log-file=memcheck.log --leak-check=full --leak-resolution=med --show-reachable=yes --error-limit=no'
alias df='df -k'
alias chpasswdwin='smbpasswd -r TRIANON -U pierre-etienne.bougu && sudo vi /etc/cifspw'
alias eclipse='~/local/bin/eclipse/eclipse -vmargs -Xms2048m -Xmx4096m -XX:PermSize=512m -XX:MaxPermSize=2048m -XX:+CMSClassUnloadingEnabled -XX:+CMSClassUnloadingEnabled'
#alias eclipse='~/local/bin/eclipse/eclipse'
alias gitkc='git log --decorate=short --format="%Cgreen%h%Cred%d %Creset%s %Cblue[%an | %ad]" --graph --date=short --all'
alias updateDebian='sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get autoremove && sudo apt-get autoclean && sudo update-flashplugin-nonfree --install && sudo update-pepperflashplugin-nonfree --install'
ulimit -c unlimited

#export LS_COLORS='di=01;34;4:ex=01;31:*.cc=34:*.cpp=34:*.hh=30:*.hpp=30'
export IGNOREOF=1

export PS1="\[\e[33;32;4m\]\u@\[\e[33;39m\]\h:\[\e[33;32m\]\w\$\[\e[m\]"

export WORKON_HOME="/home/pbougue/.venv"

export PATH="$HOME/local/bin:$HOME/dev/build/navitia/releaseClang/ed:$HOME/dev/build/navitia/releaseClang/kraken:$PATH"

#export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/ibm/ILOG/CPLEX_Studio124/cplex/bin/x86-64_sles10_4.1"
#export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/CoinAll-1.7.5/build/Cbc/src/.libs:/opt/CoinAll-1.7.5/build/Cgl/src/.libs:/opt/CoinAll-1.7.5/build/Clp/src/.libs:/opt/CoinAll-1.7.5/build/CoinUtils/src/.libs:/opt/CoinAll-1.7.5/build/Osi/src/.libs:/opt/CoinAll-1.7.5/build/Osi/src/OsiCbc/.libs:/opt/CoinAll-1.7.5/build/Osi/src/OsiClp/.libs:/opt/CoinAll-1.7.5/build/lib"

#export ILOG_LICENSE_FILE="/opt/ibm/ILOG/CPLEX_Studio124/cplex/ilm/access.ilm"
#export CVS_RSH=ssh

function dated () {
	while read line; do
		echo -n "`date --iso-8601=seconds`:"
		echo "$line"
	done
}

if [ "$PS1" ]; then
	complete -cf sudo
fi
