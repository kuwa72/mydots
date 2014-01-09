source ~/.zsh.d/zshenv

if which brew; then
	export PATH="$(brew --prefix php54)/bin:$PATH"
fi
