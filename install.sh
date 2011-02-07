#!/bin/bash

function link {
    rm $HOME/.$1
    ln -s `pwd`/$1 $HOME/.$1
}

link zshrc
link muttrc
link hgrc
link gitconfig

if [ ! -d $HOME/.bazaar ]; then mkdir $HOME/.bazaar; fi
rm $HOME/.bazaar/bazaar.conf
ln -s `pwd`/bazaar.conf $HOME/.bazaar/bazaar.conf

if [[ $(uname) = 'Linux' ]]; then
    if [ ! -d $HOME/.config ]; then mkdir $HOME/.config; fi
    rm -r $HOME/.config/awesome
    ln -s `pwd`/awesome $HOME/.config/awesome
    QUAKE=$HOME/.quakelive/quakelive/home/baseq3
elif [[ $(uname) = 'Darwin' ]]; then
    QUAKE=$HOME/Library/Application\ Support/QuakeLive/quakelive/home/baseq3
fi
if [ -d $QUAKE ]; then
    rm $QUAKE/lol2fast4u.cfg $QUAKE/autoexec.cfg
    ln -s `pwd`/lol2fast4u.cfg $QUAKE/lol2fast4u.cfg
    echo 'exec "lol2fast4u.cfg"' > $QUAKE/autoexec.cfg
fi
