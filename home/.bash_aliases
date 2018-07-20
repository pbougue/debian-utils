# custom commands

# To activate add (and uncomment) the following to your .bashrc or .zshrc
# (you'll also probably want to add .bash_env):
#
# if [ -f ~/.bash_aliases ]; then
#     . ~/.bash_aliases
# fi


# Navitia
maklangfuntion() {
	 rm -f ./maklang.log;
    make "$@" 2>&1 | tee >(GREP_COLORS='mt=00;32' egrep "^(\[ *[0-9]+\%\] )+(Linking |Scanning dependenc(ies|y) |Building |Generating )?.*") \
                         >(GREP_COLORS='mt=00;32' egrep "^(Linking |Scanning dependenc(ies|y) |Building |Generating ).*") \
                         >(egrep -v "(third_party|/linenoise/|\.pb\.).*warning: " | GREP_COLORS='mt=01;35' egrep "warning: " -A 20 -B 20) \
                         >(GREP_COLORS='mt=01;31' egrep "error: " -A 10 -B 10) \
                         > ./maklang.log
}
# alias maklang=maklangfuntion
alias maklang='make'
# alias makpbf='make protobuf_files'
alias makpbf='echo "protobuf_files: nothing to do"'
alias makdockertest='workon tyr && make docker_test && workon jormungandr'
alias maktyrtest='workon tyr && PYTHONPATH=~/dev/sources/navitia/source/navitiacommon:~/dev/sources/navitia/source/tyr py.test ~/dev/sources/navitia/source/tyr/tests && workon jormungandr'
alias maktest='workon jormungandr && make test && makdockertest'
alias maked_only='makpbf && maklang -j6 -k ed_executables'
alias maked='makpbf && maked_only; maklang -j6 -k kraken; maklang -j6 -k && maktest'
alias makraken='makpbf && maklang -j6 -k kraken; maked_only; maklang -j6 -k && maktest'
alias makall='makpbf && maklang -j6 -k && maktest'

alias dbUpgradeJormun='workon tyr && PYTHONPATH=../navitiacommon:. TYR_CONFIG_FILE=dev_settings.py ./manage_tyr.py db upgrade'


# Tartare
alias mongoTartareLaunch='docker rm -v tartare_temp_mongo && docker run -p 27017:27017 --name tartare_temp_mongo mongo:3.2'


# Visual Studio Code
alias code='workon vscode && code'


# Sublime Text
sublfunction() {
	sublime_text "$@" > /dev/null 2>&1;
}
alias subl=sublfunction


# Eclipse
alias eclipse='~/local/bin/eclipse/eclipse -vmargs -Xms2048m -Xmx4096m -XX:PermSize=512m -XX:MaxPermSize=2048m -XX:+CMSClassUnloadingEnabled -XX:+CMSClassUnloadingEnabled'
alias rustEclipse='~/local/bin/eclipse4.6.1/eclipse/eclipse -vmargs -Xms2048m -Xmx4096m -XX:PermSize=512m -XX:MaxPermSize=2048m -XX:+CMSClassUnloadingEnabled -XX:+CMSClassUnloadingEnabled'


# Git
smgitfunction() {
	git "$@";
	git submodule update --recursive;
}
alias smgit=smgitfunction
alias gitkc='git log --decorate=short --format="%Cgreen%h%Cred%d %Creset%s %Cblue[%an | %ad]" --graph --date=short --all'
alias gitk='gitk --all'


# Rust
cargo() {
    if [[ $@ == "clippy" ]]; then
        command rustup run nightly cargo clippy #--no-default-features --features nightly
    else
        command cargo "$@"
    fi
}
alias cargoUpdate='rustup update && cargo install rustfmt --force && cargo install rustsym --force && cargo install racer --force && cargo install --git https://github.com/RustDT/Rainicorn --tag version_1.x --force && rustup run nightly cargo install clippy --force && cd ~/dev/source/rls && git pull && rustup run nightly cargo install'


# Docker
alias dockerCleanContainer='docker stop $(docker ps -q); docker rm -v $(docker ps -aq)'
alias dockerClean='dockerCleanContainer; sudo docker-volume-cleanup; sudo docker run -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker:/var/lib/docker --rm martin/docker-cleanup-volumes; docker rmi $(docker images  -f dangling=true -q)'


# Python
source /usr/share/virtualenvwrapper/virtualenvwrapper.sh


# Profiling
alias doPurify='valgrind --tool=memcheck -v --log-file=memcheck.log --leak-check=full --leak-resolution=med --show-reachable=yes --error-limit=no'
alias perfRecordProcess='sudo perf record --call-graph dwarf -p'
alias perfRecord='sudo perf record --call-graph'
alias perfReport='sudo perf report -n --stdio'
# profile python cProfile
# python -m cProfile -o profile.txt  manage.py runserver 
# gprof2dot -f pstats profile.txt -o profile.dot
# dot -Tsvg profile.dot -o profile.svg


# Common
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

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
alias df='df -k'

alias updateDebian='sudo apt update && sudo apt full-upgrade && sudo apt autoremove && sudo apt autoclean && sudo update-pepperflashplugin-nonfree --install && sudo update-flashplugin-nonfree --install'


# Printer HMT
alias printConfig='echo "To change password: launch a print task, then right click printer \"Task queue\", then right-click task \"authentication\" (the user is CANALTP0/pbougue)" && system-config-printer'


# VPN paloalto
alias vpn='sudo ~/local/bin/openconnect/openconnect --protocol=gp portail-vpn.canaltp.fr'
