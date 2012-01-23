if [[ $(uname) == 'Darwin' ]]; then
  reattach-to-user-namespace -l zsh
else
  zsh
fi
