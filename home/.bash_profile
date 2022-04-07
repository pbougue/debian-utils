# custom exports

# To activate add (and uncomment) the following to your .bashrc or .zshrc:
# if [ -f ~/.bash_profile ]; then
#     . ~/.bash_profile
# fi


# zsh option
setopt no_share_history

# zprezto modules added: 'git' 'python' 'syntax-highlighting' 'history-substring-search'
# Result:
# zstyle ':prezto:load' pmodule \
#   'environment' \
#   'terminal' \
#   'editor' \
#   'history' \
#   'directory' \
#   'spectrum' \
#   'utility' \
#   'completion' \
#   'git' \
#   'python' \
#   'syntax-highlighting' \
#   'history-substring-search' \
#   'prompt'
#
# for an easier prompt, modify sorin profile (blue to light blue):
# change '4' to '12' in .zprezto/modules/prompt/functions/prompt_sorin_setup


# Navitia
export PATH="$HOME/dev/build/navitia/release/ed:$HOME/dev/build/navitia/release/kraken:$PATH"


# Python
export WORKON_HOME="~/.venv"


#Golang
export GOPATH=$HOME/dev/go
export PATH="/usr/local/go/bin:$PATH"
export PATH="$(go env GOPATH)/bin:$PATH"


# Rust
export RUST_SRC_PATH=${HOME}/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src
#export RLS_ROOT=$HOME/dev/source/rls
export PATH="$HOME/.cargo/bin:$PATH"
export RUSTC_WRAPPER=sccache


# Python
# source /usr/share/virtualenvwrapper/virtualenvwrapper.sh

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$PYENV_ROOT/shims:$PATH"
export PATH="$HOME/.local/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
# export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
# pyenv virtualenvwrapper_lazy


# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# maven
export PATH="$HOME/local/bin/maven/apache-maven-3.5.0/bin:$PATH"


# Common
ulimit -c unlimited
export PATH="$HOME/local/bin:/snap/bin:$PATH"

export BAT_THEME="Monokai Extended"



# -------------------------------------
# Archive from 20180701 (just in case):

# export WORKON_HOME="~/.venv"

# # export GOPATH=$HOME/gopath:$HOME/dev/go
# export GOPATH=$HOME/dev/go
# export RUST_SRC_PATH=${HOME}/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src
# #export RLS_ROOT=$HOME/dev/source/rls

# export PATH="$HOME/local/bin:$HOME/dev/build/navitia/release/ed:$HOME/dev/build/navitia/release/kraken:/usr/local/go/bin:$GOPATH:$GOPATH/bin:$HOME/local/bin/maven/apache-maven-3.5.0/bin:$HOME/.cargo/bin:$PATH"

# export NVM_DIR="~/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
