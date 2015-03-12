source ~/.zsh.d/zshenv

<<<<<<< HEAD
if which brew && which php; then
	export PATH="$(brew --prefix php56)/bin:$PATH"
=======
if which brew >/dev/null; then
	export PATH="$(brew --prefix php54)/bin:$PATH"
>>>>>>> defb570452066d2243183585db5acc3eb698d3dd
fi
