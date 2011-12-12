#!/usr/bin/env zsh
backup() {
  FILES=$(echo $argv | sed "s/^[^ ]* //")
  tarsnap -c -f $1-$(date +%Y-%m-%d-%H:%M) $FILES
}
backup_file() {
  [[ -e $1 ]] && backup $(basename $1) $1
}
backup_dir() {
  [[ -d $2 ]] && backup $1 $2
}
backup_last_file() {
  [[ -d $2 ]] && backup $1 $2/$(ls -t $2 | head -n 1)
}
APPSUP=$HOME/Library/Application\ Support/

backup_file $HOME/Documents/my.ledger
backup_dir private-code $CODEDIR/private
backup_last_file textexpander $APPSUP/TextExpander/Backups
backup_last_file 1password $APPSUP/1Password/Backups
