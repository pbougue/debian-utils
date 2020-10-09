#
# Executes commands at the start of an interactive session.
#

if [ -f ~/.bash_profile ]; then
    . ~/.bash_profile
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

eval "$(starship init zsh)"

autoload -Uz compinit && compinit

source ~/.zsh/completion.zsh  # after cd ~/.zsh && wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/completion.zsh
source ~/.zsh/history.zsh  # after cd ~/.zsh && wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/history.zsh

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
