source ~/.zsh.d/zshenv

if which brew >/dev/null 2>&1 && which php >/dev/null 2>&1; then
	export PATH="$(brew --prefix php56)/bin:$PATH"
fi
export PATH=~/.phpenv/bin:$PATH
eval "$(phpenv init -)"
PATH=~/.phpenv/bin:$PATH
