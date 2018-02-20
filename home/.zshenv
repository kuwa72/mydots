setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  [[ ! -r "${ZDOTDIR:-$HOME}/.${rcfile:t}" ]] && ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
