#!/usr/bin/env zsh
# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice
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
