#!/bin/zsh

link() {
  rm $HOME/.$1
  ln -s $(pwd)/$1 $HOME/.$1
}
link_custom() {
  rm $2
  ln -s $(pwd)/$1 $2
}

# don't even think about "link *rc", will remove all the rcs
link ackrc
link zshrc
link hgrc
link ctags
link gitconfig
link teamocil
link tmux.conf
link vim
link vimrc
link gvimrc
link irbrc
link inputrc
link nethackrc
link pentadactylrc
link gemrc
link weechat
link ledgerrc
link todo.actions.d


mkdir -p $HOME/.ssh
link_custom ssh_config $HOME/.ssh/config
mkdir -p $HOME/.re.pl
link_custom re.pl $HOME/.re.pl/repl.rc

echo "vim/tmp vim/tmp/undo vim/tmp/backups" | xargs mkdir -p

if [[ $(uname) = 'Linux' ]]; then
  cat ./crontab | crontab
  QUAKE=$HOME/.quakelive/quakelive/home/baseq3
elif [[ $(uname) = 'Darwin' ]]; then
  cat ./crontab ./crontab_mac | crontab
  chflags nohidden ~/Library
  defaults write -g AppleKeyboardUIMode -int 3
  defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
  defaults write -g PMPrintingExpandedStateForPrint -bool true
  defaults write com.apple.LaunchServices LSQuarantine -bool false
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
  defaults write com.apple.finder WarnOnEmptyTrash -bool false
  defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2
  echo "0x08000100:0" > $HOME/.CFUserTextEncoding
  link_custom evernote_selection.plist $HOME/Library/LaunchAgents/com.floatboth.evernote_selection.plist
  mkdir -p $HOME/Library/KeyBindings
  link_custom keybindings/DefaultKeyBinding.dict $HOME/Library/KeyBindings/DefaultKeyBinding.dict
  QUAKE=$HOME/Library/Application\ Support/QuakeLive/quakelive/home/baseq3
fi
if [[ -d $QUAKE ]]; then
  link_custom quakelive.cfg $QUAKE/quakelive.cfg
  echo 'exec "quakelive.cfg"' > $QUAKE/autoexec.cfg
fi
