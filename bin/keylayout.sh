#!/usr/bin/env zsh
# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice

if [[ -x $(which plutil) ]]; then
  LAYOUT=$(plutil -convert json -r -o - \
          ~/Library/Preferences/ByHost/com.apple.HIToolbox* | \
          grep CurrentKeyboardLayout)
  [[ $LAYOUT =~ "Russian" ]] && echo "RU"
  [[ $LAYOUT =~ "Colemak" ]] && echo "EN"
  [[ $LAYOUT =~ "Dvorak"  ]] && echo "EN"
  [[ $LAYOUT =~ "English" ]] && echo "EN"
fi
