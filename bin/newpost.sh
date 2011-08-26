#!/bin/zsh
file=~/Documents/$(date "+post-%Y-%m-%d-%H.md")
touch $file
open -a TextEdit $file
open -a Marked $file
