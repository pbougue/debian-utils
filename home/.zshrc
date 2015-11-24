#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
setopt no_share_history

source /usr/share/virtualenvwrapper/virtualenvwrapper.sh

# Customize to your needs...
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

maklangfuntion() {
	 rm -f ./maklang.log;
    make "$@" 2>&1 | tee >(GREP_COLORS='mt=00;32' egrep "^(\[ *[0-9]+\%\] )+(Linking |Scanning dependenc(ies|y) |Building |Generating )?.*") \
                         >(GREP_COLORS='mt=00;32' egrep "^(Linking |Scanning dependenc(ies|y) |Building |Generating ).*") \
                         >(egrep -v "(third_party|/linenoise/|\.pb\.).*warning: " | GREP_COLORS='mt=01;35' egrep "warning: " -A 20 -B 20) \
                         >(GREP_COLORS='mt=01;31' egrep "error: " -A 10 -B 10) \
                         > ./maklang.log
}

smgitfunction() {
	git "$@";
	git submodule update;
}

sublfunction() {
	sublime_text "$@" > /dev/null 2>&1;
}

# github API token
export HOMEBREW_GITHUB_API_TOKEN=blablibla

alias smgit=smgitfunction
alias maklang=maklangfuntion
alias subl=sublfunction
alias maktest='workon jormungandr && make test && workon eitri && make docker_test && workon jormungandr'
alias dockerClean='docker stop $(docker ps -q); docker rm -v $(docker ps -aq)'
alias ls='ls --color=auto'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
alias rm='rm -i'
alias cp='cp -i'
alias vi='vim'
alias mv='mv -i'
alias doPurify='valgrind --tool=memcheck -v --log-file=memcheck.log --leak-check=full --leak-resolution=med --show-reachable=yes --error-limit=no'
alias df='df -k'
alias eclipse='~/local/bin/eclipse/eclipse -vmargs -Xms2048m -Xmx4096m -XX:PermSize=512m -XX:MaxPermSize=2048m -XX:+CMSClassUnloadingEnabled -XX:+CMSClassUnloadingEnabled'
alias gitkc='git log --decorate=short --format="%Cgreen%h%Cred%d %Creset%s %Cblue[%an | %ad]" --graph --date=short --all'
alias gitk='gitk --all'
alias updateDebian='sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get autoremove && sudo apt-get autoclean && sudo update-flashplugin-nonfree --install && sudo update-pepperflashplugin-nonfree --install'
ulimit -c unlimited

export WORKON_HOME="/home/pbougue/.venv"

export PATH="$HOME/local/bin:$HOME/dev/build/navitia/releaseClang/ed:$HOME/dev/build/navitia/releaseClang/kraken:$PATH"

