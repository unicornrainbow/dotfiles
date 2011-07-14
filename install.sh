#!/bin/bash

function link {
    rm $HOME/.$1
    ln -s `pwd`/$1 $HOME/.$1
}

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

echo "vim/tmp vim/tmp/undo vim/tmp/swap vim/tmp/backups" | xargs mkdir -p

mkdir -p $HOME/.ssh
rm $HOME/.ssh/config
ln -s `pwd`/ssh_config $HOME/.ssh/config

mkdir -p $HOME/.bazaar
rm $HOME/.bazaar/bazaar.conf
ln -s `pwd`/bazaar.conf $HOME/.bazaar/bazaar.conf

if [[ $(uname) = 'Linux' ]]; then
    QUAKE=$HOME/.quakelive/quakelive/home/baseq3
elif [[ $(uname) = 'Darwin' ]]; then
    QUAKE=$HOME/Library/Application\ Support/QuakeLive/quakelive/home/baseq3
fi
if [[ -d $QUAKE ]]; then
    rm $QUAKE/quakelive.cfg $QUAKE/autoexec.cfg
    ln -s `pwd`/quakelive.cfg $QUAKE/quakelive.cfg
    echo 'exec "quakelive.cfg"' > $QUAKE/autoexec.cfg
fi
