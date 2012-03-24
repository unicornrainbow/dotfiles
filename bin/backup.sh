#!/usr/bin/env zsh
BACKUP_DIR=$HOME/.backup_cache
mkdir -p $BACKUP_DIR
cachepath() {
  echo $BACKUP_DIR/$(echo $1 | tr "/ " "__")
}
cache_get() {
  CPATH=$(cachepath $1)
  [[ -e $CPATH ]] && cat $CPATH
}
backup() {
  FILES=$(echo $argv | sed "s/^[^ ]* //")
  tarsnap -c -f $1-$(date +%Y-%m-%d-%H:%M) $FILES
}
backup_file() {
  [[ -e $1 ]] && backup $(basename $1) $1
}
backup_dir() {
  [[ -d $2 ]] && [[ $(cache_get $2) != $(ls -la $2) ]] && backup $1 $2 && ls -la $2 > $(cachepath $2)
}
backup_last_file() {
  FILE=$(ls -t $2 | head -n 1)
  [[ -d $2 ]] && [[ $(cache_get $2) != $FILE ]] && backup $1 $2/$FILE && echo $FILE > $(cachepath $2)
}
APPSUP=$HOME/Library/Application\ Support

backup_file $HOME/Documents/my.ledger
backup_last_file textexpander $APPSUP/TextExpander/Backups
backup_last_file 1password $APPSUP/1Password/Backups
get_ohlife.py > $HOME/.ohlife.txt
backup_file $HOME/.ohlife.txt
