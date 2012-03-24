if [[ $(uname) == 'Darwin' ]]; then
  if [[ -e $(which reattach-to-user-namespace) ]]; then
    reattach-to-user-namespace -l zsh
  else
    echo 'install reattach-to-user-namespace!'
    zsh
  fi
else
  zsh
fi
