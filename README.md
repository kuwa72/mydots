mydots
======

dotfiles for me. (powerd by homesick)

Usage
-----

* Backup your original dotfiles, If you want.
* Install homesick
* Install [dein.vim](https://github.com/Shougo/dein.vim).
* Clone [Clear-Code's zsh config](https://github.com/clear-code/zsh.d/).

```
  $ gem intall homesick
  $ git clone https://github.com/clear-code/zsh.d.git ~/.zsh.d
  $ git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
  $ curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
  $ sh ./installer.sh
  $ homesick clone kuwa72/mydots
  $ homesick symlink mydots
```

Include configurations
----------------------

* Vim
  Autosave/dein/Unite...
* Zsh
  Clear-Code's rc based with Auto-Fu.
* Bash
* Git
* tmux
  Magick key is Ctrl-t.
* RubyGems
  --no-ri --no-rdoc
* screen
  Magick key is Ctrl-t.
