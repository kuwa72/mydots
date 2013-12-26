source ~/.zsh.d/zshrc
source ~/.zsh.d/config/packages.zsh

RBENV_DIR=$HOME/.rbenv/bin

if [ -d $RBENV_DIR ]; then
  export PATH=$RBENV_DIR:$PATH
fi

if which rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

