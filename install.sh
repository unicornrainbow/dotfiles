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
link vimrc
link gvimrc
link inputrc
link nethackrc
link pentadactylrc
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

mkdir -p $HOME/.ssh
link_custom ssh_config $HOME/.ssh/config
mkdir -p $HOME/.re.pl
link_custom re.pl $HOME/.re.pl/repl.rc
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
  QUAKE=$HOME/Library/Application\ Support/QuakeLive/quakelive/home/baseq3
fi
if [[ -d $QUAKE ]]; then
  link_custom quakelive.cfg $QUAKE/quakelive.cfg
  echo 'exec "quakelive.cfg"' > $QUAKE/autoexec.cfg
fi
echo "Installed dotfiles!"
