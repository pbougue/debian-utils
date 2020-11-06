#
# Executes commands at the start of an interactive session.
#

setopt no_share_history

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

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh  # after git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsl/zsh-autosuggestions
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  # after git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

bindkey "^@" glob-alias
bindkey "^A" beginning-of-line
bindkey "^B" backward-char
bindkey "^D" delete-char-or-list
bindkey "^E" end-of-line
bindkey "^F" forward-char
bindkey "^G" send-break
bindkey "^H" backward-delete-char
bindkey "^I" expand-or-complete-with-indicator
bindkey "^J" accept-line
bindkey "^K" kill-line
bindkey "^L" clear-screen
bindkey "^M" accept-line
#bindkey "^N" history-substring-search-down
bindkey "^O" accept-line-and-down-history
#bindkey "^P" history-substring-search-up
bindkey "^Q" push-line-or-edit
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward
bindkey "^T" transpose-chars
bindkey "^U" kill-whole-line
bindkey "^V" quoted-insert
bindkey "^W" backward-kill-word
bindkey "^X^B" vi-find-prev-char
bindkey "^X^E" edit-command-line
bindkey "^X^F" vi-find-next-char
bindkey "^X^J" vi-join
bindkey "^X^K" kill-buffer
bindkey "^X^N" infer-next-history
bindkey "^X^O" overwrite-mode
bindkey "^X^R" _read_comp
bindkey "^X^S" prepend-sudo
bindkey "^X^U" undo
bindkey "^X^V" vi-cmd-mode
bindkey "^X^X" exchange-point-and-mark
bindkey "^X^]" vi-match-bracket
bindkey "^X*" expand-word
bindkey "^X=" what-cursor-position
bindkey "^X?" _complete_debug
bindkey "^XC" _correct_filename
bindkey "^XG" list-expand
bindkey "^Xa" _expand_alias
bindkey "^Xc" _correct_word
bindkey "^Xd" _list_expansions
bindkey "^Xe" _expand_word
bindkey "^Xg" list-expand
bindkey "^Xh" _complete_help
bindkey "^Xm" _most_recent_file
bindkey "^Xn" _next_tags
bindkey "^Xr" history-incremental-search-backward
bindkey "^Xs" history-incremental-search-forward
bindkey "^Xt" _complete_tag
bindkey "^Xu" undo
bindkey "^X~" _bash_list-choices
bindkey "^Y" yank
bindkey "^[^D" list-choices
bindkey "^[^G" send-break
bindkey "^[^H" backward-kill-word
bindkey "^[^I" self-insert-unmeta
bindkey "^[^J" self-insert-unmeta
bindkey "^[^L" clear-screen
bindkey "^[^M" self-insert-unmeta
bindkey "^[^[[C" emacs-forward-word
bindkey "^[^[[D" emacs-backward-word
bindkey "^[^_" copy-prev-word
bindkey "^[ " expand-history
bindkey "^[!" expand-history
bindkey "^[\"" quote-region
bindkey "^[\$" spell-word
bindkey "^['" quote-line
bindkey "^[," _history-complete-newer
bindkey "^[-" neg-argument
bindkey "^[." insert-last-word
bindkey "^[/" _history-complete-older
bindkey "^[0" digit-argument
bindkey "^[1" digit-argument
bindkey "^[2" digit-argument
bindkey "^[3" digit-argument
bindkey "^[4" digit-argument
bindkey "^[5" digit-argument
bindkey "^[6" digit-argument
bindkey "^[7" digit-argument
bindkey "^[8" digit-argument
bindkey "^[9" digit-argument
bindkey "^[;" pound-toggle
bindkey "^[<" beginning-of-buffer-or-history
bindkey "^[>" end-of-buffer-or-history
bindkey "^[?" which-command
bindkey "^[A" accept-and-hold
bindkey "^[B" emacs-backward-word
bindkey "^[C" capitalize-word
bindkey "^[D" kill-word
bindkey "^[E" expand-cmd-path
bindkey "^[F" emacs-forward-word
bindkey "^[G" get-line
bindkey "^[H" run-help
bindkey "^[K" backward-kill-line
bindkey "^[L" down-case-word
bindkey "^[M" copy-prev-shell-word
bindkey "^[N" history-search-forward
#bindkey "^[OA" history-substring-search-up
#bindkey "^[OB" history-substring-search-down
bindkey "^[OC" forward-char
bindkey "^[OD" backward-char
bindkey "^[OF" end-of-line
bindkey "^[OH" beginning-of-line
bindkey "^[Oc" emacs-forward-word
bindkey "^[Od" emacs-backward-word
bindkey "^[P" history-search-backward
bindkey "^[Q" push-line-or-edit
bindkey "^[S" spell-word
bindkey "^[T" transpose-words
bindkey "^[U" up-case-word
bindkey "^[W" copy-region-as-kill
bindkey "^[[1;5C" emacs-forward-word
bindkey "^[[1;5D" emacs-backward-word
bindkey "^[[200~" bracketed-paste
bindkey "^[[2~" overwrite-mode
bindkey "^[[3~" delete-char
bindkey "^[[5C" emacs-forward-word
bindkey "^[[5D" emacs-backward-word
bindkey "^[[A" up-line-or-history
bindkey "^[[B" down-line-or-history
bindkey "^[[C" forward-char
bindkey "^[[D" backward-char
bindkey "^[[Z" reverse-menu-complete
bindkey "^[_" redo
bindkey "^[a" accept-and-hold
bindkey "^[b" emacs-backward-word
bindkey "^[c" capitalize-word
bindkey "^[d" kill-word
bindkey "^[e" expand-cmd-path
bindkey "^[f" emacs-forward-word
bindkey "^[g" get-line
bindkey "^[h" run-help
bindkey "^[k" backward-kill-line
bindkey "^[l" down-case-word
bindkey "^[m" copy-prev-shell-word
bindkey "^[n" history-search-forward
bindkey "^[p" history-search-backward
bindkey "^[q" push-line-or-edit
bindkey "^[s" spell-word
bindkey "^[t" transpose-words
bindkey "^[u" up-case-word
bindkey "^[w" copy-region-as-kill
bindkey "^[x" execute-named-cmd
bindkey "^[y" yank-pop
bindkey "^[z" execute-last-named-cmd
bindkey "^[|" vi-goto-column
bindkey "^[~" _bash_complete-word
bindkey "^[^?" backward-kill-word
bindkey "^_" undo
bindkey " " magic-space
bindkey "!"-"~" self-insert
bindkey "^?" backward-delete-char
bindkey "\M-^@"-"\M-^?" self-insert

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
