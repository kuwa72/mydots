source ~/.zsh.d/zshenv

if which brew && which php; then
	export PATH="$(brew --prefix php56)/bin:$PATH"
fi
export PATH=~/.phpenv/bin:$PATH
eval "$(phpenv init -)"
