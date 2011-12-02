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
link conkerorrc
link gitconfig
link teamocil
link tmux.conf
link vim
link vimrc
link gvimrc
link js
link irbrc
link inputrc
link nethackrc
link pentadactylrc
link gemrc
link weechat
link ledgerrc

mkdir -p $HOME/.ssh
link_custom ssh_config $HOME/.ssh/config
mkdir -p $HOME/.re.pl
link_custom re.pl $HOME/.re.pl/repl.rc

echo "vim/tmp vim/tmp/undo vim/tmp/swap vim/tmp/backups" | xargs mkdir -p

if [[ $(uname) = 'Linux' ]]; then
  QUAKE=$HOME/.quakelive/quakelive/home/baseq3
  SUBLIME=$HOME/.config/sublime-text-2
elif [[ $(uname) = 'Darwin' ]]; then
  defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
  echo "0x08000100:0" > $HOME/.CFUserTextEncoding
  echo 'do shell script "'$(pwd)'/bin/newpost.sh"' > $HOME/Library/Application\ Support/LaunchBar/Actions/New\ post.scpt
  link_custom arrrsync.plist $HOME/Library/LaunchAgents/com.floatboth.arrrsync.plist
  link_custom evernote_selection.plist $HOME/Library/LaunchAgents/com.floatboth.evernote_selection.plist
  QUAKE=$HOME/Library/Application\ Support/QuakeLive/quakelive/home/baseq3
  SUBLIME=$HOME/Library/Application\ Support/Sublime\ Text\ 2
fi
if [[ -d $QUAKE ]]; then
  link_custom quakelive.cfg $QUAKE/quakelive.cfg
  echo 'exec "quakelive.cfg"' > $QUAKE/autoexec.cfg
fi
if [[ -d $SUBLIME ]]; then
  link_custom sublime $SUBLIME/Packages/Floatboth
fi
