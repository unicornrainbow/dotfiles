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

mkdir -p $HOME/.ssh
link_custom ssh_config $HOME/.ssh/config

echo "vim/tmp vim/tmp/undo vim/tmp/swap vim/tmp/backups" | xargs mkdir -p

if [[ $(uname) = 'Linux' ]]; then
    QUAKE=$HOME/.quakelive/quakelive/home/baseq3
elif [[ $(uname) = 'Darwin' ]]; then
    cp com.floatboth.arrrsync.plist ~/Library/LaunchAgents/
    echo 'do shell script "'$(pwd)'/bin/newpost.sh"' > ~/Library/Application\ Support/LaunchBar/Actions/New\ post.scpt
    QUAKE=$HOME/Library/Application\ Support/QuakeLive/quakelive/home/baseq3
fi
if [[ -d $QUAKE ]]; then
    link_custom quakelive.cfg $QUAKE/quakelive.cfg
    echo 'exec "quakelive.cfg"' > $QUAKE/autoexec.cfg
fi
