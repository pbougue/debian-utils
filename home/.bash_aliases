# custom commands

# To activate add (and uncomment) the following to your .bashrc or .zshrc
# (you'll also probably want to add .bash_env):
#
# if [ -f ~/.bash_aliases ]; then
#     . ~/.bash_aliases
# fi


# Python
alias workon='pyenv activate'

# mkvenvactivate() {
# 	pyenv virtualenv "$@";
#     if [ "$#" -eq 1 ]; then
#         workon "$1";
#     elif [ "$#" -eq 2 ]; then
#         workon "$2";
#     else
#         echo "\n/\!\\ NO virtualenv activated /\!\\\n";
#     fi
# }
# alias mkvirtualenvsimple='pyenv virtualenv'
# alias mkvirtualenv=mkvenvactivate

# alias lsvirtualenv='pyenv virtualenvs'
# alias rmvirtualenv='pyenv virtualenv-delete'
# alias deactivate='pyenv deactivate'


# Navitia
maklangfuntion() {
	rm -f ./maklang.log;
    time make "$@" 2>&1 | tee >(GREP_COLORS='mt=00;32' egrep "^(\[ *[0-9]+\%\] )+(Linking |Scanning dependenc(ies|y) |Building |Generating )?.*") \
                              >(GREP_COLORS='mt=00;32' egrep "^(Linking |Scanning dependenc(ies|y) |Building |Generating ).*") \
                              >(egrep -v "(third_party|/linenoise/|\.pb\.).*warning: " | GREP_COLORS='mt=01;35' egrep "warning: " -A 20 -B 20) \
                              >(GREP_COLORS='mt=01;31' egrep "error: " -A 10 -B 10) \
                              > ./maklang.log
}

function json_filter() {
    FILTER=$1; if [ ! $FILTER ]; then FILTER="*"; fi
    python -c "import sys;import json;import jmespath; print(json.dumps(jmespath.search('$FILTER', json.loads(sys.stdin.read()))))" | json_pp | highlight -S json -O ansi
}

function swap()
{
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

function makejcpu() {
	export MAKEFLAGS="-j $1"
}

alias nomakejscpu='unset MAKEFLAGS'


# alias maklang=maklangfuntion
alias maklang='time make'
# alias makpbf='make protobuf_files'
alias makpbf='echo "protobuf_files: nothing to do"'
alias maktyrdockertest='workon tyr_eitri && time make -j 1 docker_test ; workon jormungandr'
alias makdockertest='workon eitri && time _VERBOSE=1 make -j 1 run_test ; echo "Check ./ed/docker_tests/results_ed_integration_test.xml for results" ; workon jormungandr'
alias maktyrtest='workon tyr && time make -j 1 tyr_tests ; workon jormungandr'
alias makchaostest='workon tyr && time make -j 1 chaos_tests ; workon jormungandr'
# alias maktyrtest='workon tyr && time PYTHONPATH=$PYTHONPATH:~/dev/sources/navitia/source/navitiacommon:~/dev/sources/navitia/source/tyr py.test --doctest-modules ~/dev/sources/navitia/source/tyr/tests ; workon jormungandr'
alias makjormuntest='workon jormungandr && time JORMUNGANDR_USE_SERPY=True PYTHONPATH=$PYTHONPATH:~/dev/sources/navitia/source/navitiacommon:~/dev/sources/navitia/source/jormungandr/jormungandr py.test --doctest-modules ~/dev/sources/navitia/source/jormungandr/jormungandr'
alias makintegrationtest='workon jormungandr && time JORMUNGANDR_USE_SERPY=True KRAKEN_BUILD_DIR=~/dev/build/navitia/release PYTHONPATH=$PYTHONPATH:~/dev/sources/navitia/source/navitiacommon:~/dev/sources/navitia/source/jormungandr/tests py.test --doctest-modules ~/dev/sources/navitia/source/jormungandr/tests'

alias maktest='workon jormungandr && time make test ; maktyrtest ; makdockertest ; makchaostest' # ; maktyrdockertest'
alias maked_only='makpbf && maklang -k ed_executables'
alias maked='makpbf && maked_only; maklang -k kraken; maklang -k && maktest'
alias makraken='makpbf && maklang -k kraken; maked_only; maklang -k && maktest'
alias makall='makpbf && maklang -k && maktest'

alias jormungandr='workon jormungandr && PYTHONPATH=$PYTHONPATH:~/dev/sources/navitia/source/jormungandr:~/dev/sources/navitia/source/navitiacommon:~/dev/sources/navitia/source/jormungandr/jormungandr PYTHONUNBUFFERED=1 JORMUNGANDR_CONFIG_FILE=~/dev/sources/navitia/source/jormungandr/jormungandr/dev_settings.py FLASK_APP=jormungandr:app flask run -p 5000 -h 0.0.0.0'
alias tyr='workon tyr && PYTHONPATH=$PYTHONPATH:~/dev/sources/navitia/source/tyr:~/dev/sources/navitia/source/navitiacommon PYTHONUNBUFFERED=1 TYR_CONFIG_FILE=~/dev/sources/navitia/source/tyr/tyr/dev_settings.py python ~/dev/sources/navitia/source/tyr/manage_tyr.py runserver -p 5002 ; workon jormungandr'
alias tyrsetup='workon tyr && PYTHONPATH=$PYTHONPATH:~/dev/sources/navitia/source/tyr PYTHONUNBUFFERED=1 python ~/dev/sources/navitia/source/tyr/setup.py build ; workon jormungandr'

alias dbUpgradeJormun='workon tyr && time PYTHONPATH=../navitiacommon:. TYR_CONFIG_FILE=dev_settings.py ./manage_tyr.py db upgrade'

alias updateVenvNavitia='workon jormungandr && pip install -U pip setuptools wheel && pip install -r ~/dev/sources/navitia/source/jormungandr/requirements_dev.txt -U \
                        && workon eitri && pip install -U pip setuptools wheel && pip install -r ~/dev/sources/navitia/source/eitri/requirements.txt -U \
                        && workon tyr_eitri && pip install -U pip setuptools wheel && pip install -r ~/dev/sources/navitia/source/eitri/requirements.txt -U && pip install -r ~/dev/sources/navitia/source/tyr/requirements_dev.txt -U \
                        && workon tyr && pip install -U pip setuptools wheel && pip install -r ~/dev/sources/navitia/source/tyr/requirements_dev.txt -U \
                        && workon cities && pip install -U pip setuptools wheel && pip install -r ~/dev/sources/navitia/source/cities/requirements.txt -U \
                        && workon monitor && pip install -U pip setuptools wheel && pip install -r ~/dev/sources/navitia/source/monitor/requirements.txt -U'

alias installSslNavitia='sudo apt install libssl-dev'

resetinstanceed() {
    if [ $# -ne 1 ];
        then echo "Usage: $0 instance" >&2
        exit 1
    fi

    dropdb $1
    createdb $1 -O navitia
    psql $1 -c "create extension postgis;"
    pushd ~/dev/sources/navitia/source/sql
    PYTHONPATH=. alembic -x dbname="postgresql://navitia:navitia@localhost/$1" upgrade head
    popd
}
alias resetEdDefault='resetinstanceed default'

eitri () {
    workon eitri &&
    cd ~/dev/sources/navitia/source/eitri &&
    time PYTHONPATH=$PYTHONPATH:~/dev/sources/navitia/source/eitri:~/dev/sources/navitia/source/navitiacommon python ~/dev/sources/navitia/source/eitri/eitri.py -e ~/dev/build/navitia/release/ed -d $1 &&
    mv data.nav.lz4 $2 ;
    cd - ;
    workon jormungandr
}
alias eitriBenchScenari='eitri ~/dev/run/navitia/default/data/Benchmark_Distributed_VS_New_Default/ ~/dev/run/navitia/default/data.nav.lz4'
#alias eitriBenchScenari='workon eitri && cd ~/dev/sources/navitia/source/eitri && time PYTHONPATH=$PYTHONPATH:~/dev/sources/navitia/source/eitri:~/dev/sources/navitia/source/navitiacommon python ~/dev/sources/navitia/source/eitri/eitri.py ~/dev/run/navitia/default/data/Benchmark_Distributed_VS_New_Default/ && mv data.nav.lz4 ~/dev/run/navitia/default/bina_output/ ; mv ~/dev/run/navitia/default/bina_output/data.nav.lz4 ~/dev/run/navitia/default/data.nav.lz4 ; cd - ; workon jormungandr'

# pre-commit
alias precommitClean='pre-commit clean'

# mypy
alias mypypass='workon navitia-precommit && MYPYPATH=.:../navitiacommon mypy --ignore-missing-imports --py2'
alias mypyJormun='pushd ~/dev/sources/navitia/source/jormungandr && mypypass jormungandr ; popd'

alias mkVirtualenvPrecommit='mkvirtualenv -p python3.7 navitia-precommit && pip install -r ~/dev/sources/navitia/requirements_precommit.txt -U'
alias precommitNav='workon navitia-precommit && pre-commit run --all && mypyJormun'


# kirin
alias kirin='workon kirin && PYTHONPATH=$PYTHONPATH:~/dev/sources/kirin PYTHONUNBUFFERED=1 KIRIN_CONFIG_FILE=~/dev/sources/kirin/kirin/dev_settings.py python ~/dev/sources/kirin/manage.py runserver -p 54746'
alias makkirintest='workon kirin && ./setup.py build_pbf && time PYTHONPATH=$PYTHONPATH:~/dev/sources/kirin KIRIN_CONFIG_FILE=~/dev/sources/kirin/kirin/test_settings.py py.test --doctest-modules ~/dev/sources/kirin'
alias kirinDockerBuild='workon artemis_ng && cd ~/dev/sources/kirin && docker build -t kirin .'
alias precommitKirin='workon precommit && cd ~/dev/sources/kirin && pre-commit run --all'


# navitia-docker-compose
alias dockerPullNavitiaDevImages='docker pull navitia/tyr-worker:dev && docker pull navitia/jormungandr:dev && docker pull navitia/kraken:dev && docker pull navitia/tyr-web:dev && docker pull navitia/tyr-beat:dev && docker pull navitia/instances-configurator:dev'
alias kirinConfiguratorDockerBuild='workon artemis_ng && cd ~/dev/sources/navitia-docker-compose/kirin/ && docker build -f Dockerfile-kirin-configurator -t kirin_configurator .'
alias artemisComposeUp='workon artemis_ng && cd ~/dev/sources/navitia-docker-compose/ && TAG=dev docker-compose -f docker-compose.yml -f artemis/docker-artemis-instance.yml -f kirin/docker-compose_kirin.yml up'
alias artemisComposeDown='workon artemis_ng && cd ~/dev/sources/navitia-docker-compose/ && TAG=dev docker-compose -f docker-compose.yml -f artemis/docker-artemis-instance.yml -f kirin/docker-compose_kirin.yml down --volumes'


# artemis
alias artemis-='workon artemis_ng && time CONFIG_FILE=dev_settings.py PYTHONPATH=$PYTHONPATH:~/dev/sources/artemis py.test'
alias artemisCitiesAirport01='artemis- artemis/tests/airport01_test.py'
alias artemisAirport01='artemisCitiesAirport01 --skip_cities'
alias artemisGuichetUnique='artemis- artemis/tests/guichet_unique_test.py --skip_cities'
alias artemisGuichetUniqueNoBina='artemisGuichetUnique --skip_bina'
alias artemisGuichetUniqueNewDefault='artemisGuichetUnique -k "TestGuichetUniqueNewDefault"'
alias artemisGuichetUniqueNoBinaNewDefault='artemisGuichetUniqueNoBina -k "TestGuichetUniqueNewDefault"'
alias artemisNoIdfm='artemis- artemis/tests/ -k "not TestIdfM"'


# mimir
alias mimirEsDocker='docker run -d --name mimir_test -p 9200:9200 -p 9300:9300 elasticsearch:2-alpine'
alias osm2mimirChambray='RUST_LOG=debug ./target/debug/osm2mimir --input ~/Téléchargements/chambray-lille.osm.pbf --level=8 --level=9 --import-way --import-admin --import-poi --dataset=chambray --connection-string=http://localhost:9200'
alias bragiDebug='RUST_LOG=debug ./target/debug/bragi --connection-string=http://localhost:9200'

alias installSslMimir='sudo apt install libssl1.0-dev'


# Tartare
alias mongoTartareLaunch='docker rm -v tartare_temp_mongo && docker run -p 27017:27017 --name tartare_temp_mongo mongo:3.2'
alias maktartaretest='workon tartare && time PYTHONPATH=$PYTHONPATH:~/dev/sources/tartare py.test --doctest-modules ~/dev/sources/tartare/tests'
alias tartare='workon tartare && PYTHONPATH=$PYTHONPATH:~/dev/sources/tartare/tartare PYTHONUNBUFFERED=1 python ~/dev/sources/tartare/tartare/app.py flask run'


# Visual Studio Code
# alias code='workon vscode && code'


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
# alias git='workon precommit; git'
alias gitkc='git log --decorate=short --format="%Cgreen%h%Cred%d %Creset%s %Cblue[%an | %ad]" --graph --date=short --all'
alias gitk='gitk --all'


# Rust
# cargo() {
#     if [[ $@ == "clippy" ]]; then
#         command rustup run nightly cargo clippy #--no-default-features --features nightly
#     else
#         command cargo "$@"
#     fi
# }
# alias cargoUpdate='rustup update'
alias rustSetup='rustup toolchain install stable && rustup component add rustfmt clippy rust-src rls rust-analysis rust-docs llvm-tools-preview'
alias cargoInstalls='cargo install cargo-audit \
                                   cargo-cache \
                                   cargo-tomlfmt \
                                   cargo-udeps \
                                   cargo-valgrind \
                                   cargo-tarpaulin \
                                   grcov \
                                   cargo-expand \
                                   wasm-pack'
                                #  cargo-update \
                                #  cargo-edit \
alias rustUpdate='rustup update && cargoInstalls'

alias candidateUtilsInstall='cargo install grex \
                                           bandwhich \
                                           xsv \
                                           jless \
                                           simple-http-server \
                                           czkawka_gui'
alias utilsInstall='sccacheInstall \
                    && starshipInstall \
                    && exaInstall \
                    && batInstall \
                    && deltaInstall \
                    && fdInstall \
                    && ripgrepInstall \
                    && dustInstall \
                    && hyperfineInstall \
                    && csviewInstall \
                    && bottomInstall'
alias starshipInstall='githubReleaseInstall starship/starship "starship-x86_64-unknown-linux-gnu\.tar\.gz" tar starship'
alias sccacheInstall='githubReleaseInstall mozilla/sccache "sccache-v[0-9\.]+-x86_64-unknown-linux-musl\.tar\.gz" tar sccache'
alias exaInstall='githubReleaseInstall ogham/exa "exa-linux-x86_64-v[0-9\.]+\.zip" zip exa'
alias batInstall='githubReleaseInstall sharkdp/bat "bat_[0-9\.]+_amd64\.deb" deb'
alias deltaInstall='githubReleaseInstall dandavison/delta "git-delta_[0-9\.]+_amd64\.deb" deb'
alias fdInstall='githubReleaseInstall sharkdp/fd "fd_[0-9\.]+_amd64\.deb" deb'
alias ripgrepInstall='githubReleaseInstall BurntSushi/ripgrep "ripgrep_[0-9\.\-]+_amd64\.deb" deb'
alias dustInstall='githubReleaseInstall bootandy/dust "du-dust_[0-9\.]+_amd64\.deb" deb'
alias hyperfineInstall='githubReleaseInstall sharkdp/hyperfine "hyperfine_[0-9\.]+_amd64\.deb" deb'
alias csviewInstall='githubReleaseInstall wfxr/csview "csview-musl_[0-9\.]+_amd64\.deb" deb'
alias bottomInstall='githubReleaseInstall ClementTsang/bottom "bottom_[0-9\.]+_amd64\.deb" deb'

githubReleaseInstall() {
    # githubReleaseInstall sharkdp/bat "bat_[0-9\.]+_amd64\.deb" deb
    # githubReleaseInstall ogham/exa "exa-linux-x86_64-v[0-9\.]+\.zip" zip exa
    # githubReleaseInstall starship/starship "starship-x86_64-unknown-linux-gnu\.tar\.gz" tar starship
    if [ $# -ne 3 ] && [ $# -ne 4 ];
        then echo "Usage: $0 <user/repo> <archive_name_pattern> <installer_type> [<bin_name>]" >&2
        return 1
    fi

    dir="$(echo $1 | sed -e 's#\([^\/]\+\)\/\([^\/]\+\)#\1-\2_installer#g')"

    mkdir -p ~/local/bin/${dir}
    pushd ~/local/bin/${dir}
    curl -L -H "Accept: application/vnd.github+json" https://api.github.com/repos/$1/releases/latest > candidate.json
    version="$(egrep "^  \"name\": \".+\",?$" candidate.json | cut -d \" -f 4)"
    candidate_version_date="${version}_$(egrep "^  \"created_at\": \".+\",?$" candidate.json | cut -d \" -f 4)"
    current_version_date="none"
    if [ -f current.json ]; then
        current_version_date="$(egrep "^  \"name\": \".+\",?$" current.json \
                                | cut -d \" -f 4)_$(egrep "^  \"created_at\": \".+\",?$" current.json \
                                | cut -d \" -f 4)"
    fi
    echo
    if [ ${candidate_version_date} != ${current_version_date} ]; then
        echo "New version ${candidate_version_date} to be installed for $1"

        REPLY=""
        vared -p "Continue (Y/n)? " REPLY
        echo ""
        if [ $REPLY = "Y" ]; then
            curl -L https://github.com/$1/releases/latest/download/$(egrep "\"name\": \"$2\"" candidate.json | cut -d \" -f 4) -o candidate.installer
            if [ $3 = deb ]; then
                sudo dpkg -i candidate.installer
            fi
            if [ $3 = zip ]; then
                unzip -j -o candidate.installer
                pushd ~/local/bin
                echo $4
                ln -snf  ~/local/bin/${dir}/$4 $4
                popd
            fi
            if [ $3 = tar ]; then
                tar -xvf candidate.installer --xform='s#^.+/##x'
                pushd ~/local/bin
                ln -snf  ~/local/bin/${dir}/$4 $4
                popd
            fi
            mv -f candidate.json current.json
            mv -f candidate.installer current.installer
        fi
    fi
    popd
}


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
alias grep='rg'
alias gr-help='grex'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias jgrep='jsonGrep'
alias ls='exa'
alias ll='exa -alFh'
# alias ll='ls -alFh'
alias tree='exa -alFhT'
alias la='ls -A'
alias l='ls -CF'
alias rm='rm -i'
alias cp='cp -i'
alias vi='vim'
alias mv='mv -i'
alias df='df -k'
alias cat='bat'
alias timeBench='hyperfine'
alias du='dust'  # or 'ncdu'
alias md='mkdir -p'
alias rd='rmdir'

# To be filled before real use
alias usbKeyCreate='echo "sudo dd bs=4M status=progress oflag=sync if=</path/to/iso> of=</path/to/volume/like/dev/sda (use _sudo fdisk -l_ or _lsblk_)> && sync"'
# To be filled before real use
alias usbKeyWipe='echo "sudo dd if=/dev/zero of=</path/to/volume/like/dev/sda (use _sudo fdisk -l_ or _lsblk_)> bs=4M && sync"'

# https://askubuntu.com/questions/271387/how-to-restart-wifi-connection
alias wifiRestart='nmcli radio wifi off && sleep 5 && nmcli radio wifi on'
alias networkRestart='sudo systemctl restart NetworkManager.service'
alias awsVpnDns='sudo ln -snf /home/pbougue/local/bin/vpn_aws/resolv.conf /etc/resolv.conf'
alias defaultVpnDns='sudo ln -snf /run/systemd/resolve/resolv.conf /etc/resolv.conf'
alias bluetoothStart='/etc/init.d/bluetooth start'
alias bluetoothStop='/etc/init.d/bluetooth stop'

alias updateDebian='sudo apt update \
                    && sudo apt full-upgrade \
                    && sudo apt autoremove \
                    && sudo apt-get clean \
                    && utilsInstall \
                    && pyenv update \
                    && poetry self update \
                    && sudo rclone selfupdate \
                    && sudo snap refresh'

jsonGrep () {
    gron $2 | grep $1 | gron --ungron
}

# format json (grep is optional but can help when extra output is done, like headers)
jsonCurl () {
    curl $@ | grep '^[[:blank:]]*{.*}[[:blank:]]*$' | jq .
}

# time request
timeCurl () {
    curl -w '\n< Total-Time: %{time_total}\n"' -s $@
}

# maximum info on the request (time in seconds, Content-Length in bytes)
infoCurl () {
    curl -v -w '\n< Total-Time: %{time_total}\n"' $@
}

alias bandwidthCurl='curl -4 -o /dev/null http://bouygues.testdebit.info/1G.iso'

# OSM
alias josm='java -jar ~/local/bin/josm/josm-tested.jar'


# Printer HMT
alias printConfig='echo "To change password: launch a print task, then right click printer \"Task queue\", then right-click task \"authentication\" (the user is CANALTP0/pbougue)" && system-config-printer'


# Avahi (to allow .local domains)
alias avahiStop='sudo systemctl disable avahi-daemon.service ; sudo systemctl disable avahi-daemon.socket ; sleep 1s ; sudo systemctl stop avahi-daemon.socket ; sleep 1s ; sudo systemctl stop avahi-daemon.service'


# VPN paloalto
alias vpn='avahiStop ; sleep 2s ; globalprotect launch-ui'
alias vpnOpenconnect='avahiStop ; sleep 2s ; sudo ~/local/bin/openconnect/openconnect --protocol=gp portail-vpn.canaltp.fr --servercert pin-sha256:7fGzNilYrnKKgCVSk87uK0Uz2ATa36svNMy86gBSVXg='

# HTTP mocks and help
alias httpMocks='echo "You can use :\n    https://www.mocky.io/\n    https://github.com/TheWaWaR/simple-http-server\n    python -m SimpleHTTPServer\n    http POST url @/path/to/file"'

# Diff and rsync
alias manRsyncDiff='echo "Show diffs based on checksum (do not forget final `/` after <LEFT>/) :\n    deleting=file missing in LEFT, +++=file missing in RIGHT, others=file exists but different\n    rsync -avnci --delete --no-group --no-owner --no-perms --no-times <LEFT>/ <RIGHT>"'
alias rsyncDiff='rsync -avnci --delete --no-group --no-owner --no-perms --no-times'
alias manRsyncFuzzyDiff='echo "Show fuzzy diffs based on time and size (do not forget final `/` after <LEFT>/) :\n    deleting=file missing in LEFT, +++=file missing in RIGHT, others=file exists but different\n    rsync -avni --delete --no-group --no-owner --no-perms -@ 1 <LEFT>/ <RIGHT>"'
alias rsyncFuzzyDiff='rsync -avni --delete --no-group --no-owner --no-perms -@ 1'

# game
alias dualshock='workon ds4 && ds4drv --hidraw'
