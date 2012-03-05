#!/bin/bash
LAYOUT=$(plutil -convert json -r -o - \
        ~/Library/Preferences/ByHost/com.apple.HIToolbox* | \
        grep CurrentKeyboardLayout)
[[ $LAYOUT =~ "Russian" ]] && echo "RU"
[[ $LAYOUT =~ "Colemak" ]] && echo "EN"
[[ $LAYOUT =~ "Dvorak"  ]] && echo "EN"
[[ $LAYOUT =~ "English" ]] && echo "EN"
