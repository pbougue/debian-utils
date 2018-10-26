# custom commands

# To activate add (and uncomment) the following to your .bashrc or .zshrc
# (you'll also probably want to add .bash_env):
#
# if [ -f ~/.bash_aliases ]; then
#     . ~/.bash_aliases
# fi


# Python
alias mkvirtualenv='pyenv virtualenv'
alias lsvirtualenv='pyenv virtualenvs'
alias rmvirtualenv='pyenv virtualenv-delete'
alias workon='pyenv activate'
alias deactivate='pyenv deactivate'


# Navitia
maklangfuntion() {
	rm -f ./maklang.log;
    time make "$@" 2>&1 | tee >(GREP_COLORS='mt=00;32' egrep "^(\[ *[0-9]+\%\] )+(Linking |Scanning dependenc(ies|y) |Building |Generating )?.*") \
                              >(GREP_COLORS='mt=00;32' egrep "^(Linking |Scanning dependenc(ies|y) |Building |Generating ).*") \
                              >(egrep -v "(third_party|/linenoise/|\.pb\.).*warning: " | GREP_COLORS='mt=01;35' egrep "warning: " -A 20 -B 20) \
                              >(GREP_COLORS='mt=01;31' egrep "error: " -A 10 -B 10) \
                              > ./maklang.log
}

# alias maklang=maklangfuntion
alias maklang='time make'
# alias makpbf='make protobuf_files'
alias makpbf='echo "protobuf_files: nothing to do"'
alias maktyrdockertest='workon tyr && time make docker_test ; workon jormungandr'
alias makdockertest='workon eitri && time make run_test ; workon jormungandr'
alias maktyrtest='workon tyr && time make tyr_tests ; workon jormungandr'
alias makjormuntest='workon jormungandr && time JORMUNGANDR_USE_SERPY=True PYTHONPATH=$PYTHONPATH:~/dev/sources/navitia/source/navitiacommon:~/dev/sources/navitia/source/jormungandr/jormungandr py.test --doctest-modules ~/dev/sources/navitia/source/jormungandr/jormungandr'
alias makintegrationtest='workon jormungandr && time JORMUNGANDR_USE_SERPY=True KRAKEN_BUILD_DIR=~/dev/build/navitia/releaseClang PYTHONPATH=$PYTHONPATH:~/dev/sources/navitia/source/navitiacommon:~/dev/sources/navitia/source/jormungandr/tests py.test --doctest-modules ~/dev/sources/navitia/source/jormungandr/tests'

alias maktest='workon jormungandr && time make test && maktyrdockertest'
alias maked_only='makpbf && maklang -j6 -k ed_executables'
alias maked='makpbf && maked_only; maklang -j6 -k kraken; maklang -j6 -k && maktest'
alias makraken='makpbf && maklang -j6 -k kraken; maked_only; maklang -j6 -k && maktest'
alias makall='makpbf && maklang -j6 -k && maktest'

alias jormungandr='workon jormungandr && PYTHONPATH=$PYTHONPATH:~/dev/sources/navitia/source/jormungandr:~/dev/sources/navitia/source/navitiacommon:~/dev/sources/navitia/source/jormungandr/jormungandr PYTHONUNBUFFERED=1 JORMUNGANDR_CONFIG_FILE=~/dev/sources/navitia/source/jormungandr/jormungandr/dev_settings.py JORMUNGANDR_USE_SERPY=True python ~/dev/sources/navitia/source/jormungandr/jormungandr/manage.py runserver -p 5000'
alias tyr='workon tyr && PYTHONPATH=$PYTHONPATH:~/dev/sources/navitia/source/tyr:~/dev/sources/navitia/source/navitiacommon PYTHONUNBUFFERED=1 TYR_CONFIG_FILE=~/dev/sources/navitia/source/tyr/tyr/dev_settings.py python ~/dev/sources/navitia/source/tyr/manage_tyr.py runserver -p 5002 ; workon jormungandr'
alias tyrsetup='workon tyr && PYTHONPATH=$PYTHONPATH:~/dev/sources/navitia/source/tyr PYTHONUNBUFFERED=1 python ~/dev/sources/navitia/source/tyr/setup.py build ; workon jormungandr'

alias dbUpgradeJormun='workon tyr && time PYTHONPATH=../navitiacommon:. TYR_CONFIG_FILE=dev_settings.py ./manage_tyr.py db upgrade'


eitri () {
    workon eitri &&
    cd ~/dev/sources/navitia/source/eitri &&
    time PYTHONPATH=$PYTHONPATH:~/dev/sources/navitia/source/eitri:~/dev/sources/navitia/source/navitiacommon python ~/dev/sources/navitia/source/eitri/eitri.py $1 &&
    mv data.nav.lz4 $2 ;
    cd - ;
    workon jormungandr
}
alias eitriBenchScenari='eitri ~/dev/run/navitia/default/data/Benchmark_Distributed_VS_New_Default/ ~/dev/run/navitia/default/data.nav.lz4'
#alias eitriBenchScenari='workon eitri && cd ~/dev/sources/navitia/source/eitri && time PYTHONPATH=$PYTHONPATH:~/dev/sources/navitia/source/eitri:~/dev/sources/navitia/source/navitiacommon python ~/dev/sources/navitia/source/eitri/eitri.py ~/dev/run/navitia/default/data/Benchmark_Distributed_VS_New_Default/ && mv data.nav.lz4 ~/dev/run/navitia/default/bina_output/ ; mv ~/dev/run/navitia/default/bina_output/data.nav.lz4 ~/dev/run/navitia/default/data.nav.lz4 ; cd - ; workon jormungandr'


# kirin
alias kirin='workon kirin && PYTHONPATH=$PYTHONPATH:~/dev/sources/kirin PYTHONUNBUFFERED=1 KIRIN_CONFIG_FILE=~/dev/sources/kirin/kirin/dev_settings.py python ~/dev/sources/kirin/manage.py runserver -p 5001'
alias makkirintest='workon kirin && time PYTHONPATH=$PYTHONPATH:~/dev/sources/kirin KIRIN_CONFIG_FILE=~/dev/sources/kirin/kirin/test_settings.py py.test --doctest-modules ~/dev/sources/kirin'


# Tartare
alias mongoTartareLaunch='docker rm -v tartare_temp_mongo && docker run -p 27017:27017 --name tartare_temp_mongo mongo:3.2'
alias maktartaretest='workon tartare && time PYTHONPATH=$PYTHONPATH:~/dev/sources/tartare py.test --doctest-modules ~/dev/sources/tartare/tests'
alias tartare='workon tartare && PYTHONPATH=$PYTHONPATH:~/dev/sources/tartare/tartare PYTHONUNBUFFERED=1 python ~/dev/sources/tartare/tartare/app.py flask run'

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


# Profiling
alias doPurify='time valgrind --tool=memcheck -v --log-file=memcheck.log --leak-check=full --leak-resolution=med --show-reachable=yes --error-limit=no'
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

alias wifiRestart='sudo systemctl restart NetworkManager.service'

alias updateDebian='sudo apt update && sudo apt full-upgrade && sudo apt autoremove && sudo apt autoclean && sudo update-pepperflashplugin-nonfree --install && sudo update-flashplugin-nonfree --install'

# format json (grep is optional but can help when extra output is done, like headers)
jsonCurl () {
    curl $@ | grep '^[[:blank:]]*{.*}[[:blank:]]*$' | jq .
}

# time request
timeCurl () {
    curl -w '\n< Total-Time: %{time_total}"' -s $@
}

# maximum info on the request (time in seconds, Content-Length in bytes)
infoCurl () {
    curl -v -w '\n< Total-Time: %{time_total}"' $@
}


# Printer HMT
alias printConfig='echo "To change password: launch a print task, then right click printer \"Task queue\", then right-click task \"authentication\" (the user is CANALTP0/pbougue)" && system-config-printer'


# VPN paloalto
alias vpn='sudo systemctl disable avahi-daemon.service ; sudo systemctl disable avahi-daemon.socket ; sleep 1s ; sudo systemctl stop avahi-daemon.socket ; sleep 1s ; sudo systemctl stop avahi-daemon.service ; sudo ~/local/bin/openconnect/openconnect --protocol=gp portail-vpn.canaltp.fr'
