# -*- sh -*-

# パッケージ管理システムを読み込む。
source ~/.zsh.d/package.zsh

# パッケージがインストールされていなければGitHubからcloneしてくる。
package-install github zsh-users/zsh-history-substring-search
package-install github zsh-users/zsh-syntax-highlighting
package-install github tarruda/zsh-autosuggestions
package-install github zsh-users/zsh-completions

# パッケージを読み込む。
source $(package-directory zsh-users/zsh-history-substring-search)/zsh-history-substring-search.zsh
source $(package-directory zsh-users/zsh-syntax-highlighting)/zsh-syntax-highlighting.zsh
source $(package-directory tarruda/zsh-autosuggestions)/autosuggestions.zsh
fpath=($(package-directory zsh-users/zsh-completions)/src $fpath)

# autosuggestionsを初期化する。
zle-line-init() {
  zle autosuggest-start
}
zle -N zle-line-init

# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

bindkey '^T' autosuggest-toggle

rm -f ~/.zcompdump; compinit
