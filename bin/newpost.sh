#!/bin/zsh
file=~/Documents/$(date "+post-%Y-%m-%d-%H.md")
touch $file
open -a Sublime\ Text\ 2 $file
open -a Marked $file