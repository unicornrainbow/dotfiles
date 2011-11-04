if [[ $IS_MAC -eq 1 ]]; then
  reattach-to-user-namespace -l zsh
else
  zsh
fi
