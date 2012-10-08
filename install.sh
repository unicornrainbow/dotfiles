#!/bin/zsh
pwd > ~/.dotfiles_location

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
link gitignore
link teamocil
link tmux.conf
link vim
link emacs
link emacs.d
link inputrc
link gemrc
link railsrc
link weechat
link ledgerrc
link lesskey
link urlview
link offlineimaprc
link msmtprc
link mutt
link_custom mutt/muttrc $HOME/.muttrc
link_custom irbrc.rb $HOME/.irbrc

link_custom vim/vimrc $HOME/.vimrc
link_custom vim/gvimrc $HOME/.gvimrc
mkdir -p $HOME/.config/fish
link_custom config.fish $HOME/.config/fish/config.fish
mkdir -p $HOME/.ssh
link_custom ssh_config $HOME/.ssh/config
mkdir -p $HOME/.lein
link_custom lein/init.clj $HOME/.lein/init.clj
link_custom lein/profiles.clj $HOME/.lein/profiles.clj

echo "vim/tmp vim/tmp/undo vim/tmp/backups" | xargs mkdir -p

if [[ $(uname) = 'Linux' ]]; then
  cat ./crontab | crontab
  QUAKE=$HOME/.quakelive/quakelive/home/baseq3
elif [[ $(uname) = 'Darwin' ]]; then
  cat ./crontab ./crontab_mac | crontab
  mkdir -p $HOME/Library/KeyBindings
  link_custom keybindings/DefaultKeyBinding.dict $HOME/Library/KeyBindings/DefaultKeyBinding.dict
  LAUNCHBAR=$HOME/Library/Application\ Support/LaunchBar
  [[ -d $LAUNCHBAR ]] && link_custom launchbar.plist.xml $LAUNCHBAR/Configuration.plist
  QUAKE=$HOME/Library/Application\ Support/QuakeLive/quakelive/home/baseq3
fi
if [[ -d $QUAKE ]]; then
  link_custom quakelive.cfg $QUAKE/quakelive.cfg
  echo 'exec "quakelive.cfg"' > $QUAKE/autoexec.cfg
fi
echo "Installed dotfiles!"
