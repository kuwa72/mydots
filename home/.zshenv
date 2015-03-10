source ~/.zsh.d/zshenv

if which brew >/dev/null; then
	export PATH="$(brew --prefix php54)/bin:$PATH"
fi
