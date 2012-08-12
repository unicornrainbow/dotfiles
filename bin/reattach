#!/usr/bin/env bash
# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice
if [[ $(uname) == 'Darwin' ]]; then
  export PATH=$PATH:$(cat ~/.dotfiles_location)/bin/tmux-osx-paste-fix
  if [[ -e $(which reattach-to-user-namespace) ]]; then
    reattach-to-user-namespace -l $1
  else
    echo 'install reattach-to-user-namespace!'
    $1
  fi
else
  $1
fi
