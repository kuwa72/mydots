source ~/.zsh.d/zshrc
source ~/.zsh.d/config/packages.zsh

#To enable shims and autocompletion add to your profile:
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export LANG=ja_JP.UTF-8

RBENV_DIR=$HOME/.rbenv/bin

if [ -d $RBENV_DIR ]; then
  export PATH=$RBENV_DIR:$PATH
fi

LINUXBREW_DIR=$HOME/.linuxbrew/bin

if [ -d $LINUXBREW_DIR ]; then
  export PATH=$LINUXBREW_DIR:$PATH
fi

if which rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

if [ -x "$(which lv)" ]; then
  if [ `uname -s` = "CYGWIN_NT-5.1" ]; then
    alias lv='TERM=cygwin lv'
    export PAGER='TERM=cygwin lv'
  else
    if which lv > /dev/null 2>&1; then
      export PAGER=lv
    fi
  fi
fi

if [ 'Darwin' = $(uname -s) ] && which brew >/dev/null 2>&1; then
  #To use Homebrew's directories rather than ~/.rbenv add to your profile:
  export RBENV_ROOT=/usr/local/var/rbenv

  if brew info nvm >/dev/null 2>&1; then
    export NVM_DIR=~/.nvm
    source $(brew --prefix nvm)/nvm.sh
  fi
else
  [ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh # This loads NVM
fi

source ~/.aliases

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if type complete &>/dev/null; then
  _npm_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###
. ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

#direnv settings
export EDITOR=nvim
eval "$(direnv hook zsh)"
. /Users/yuichiro/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

where pyenv && eval "$(pyenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
