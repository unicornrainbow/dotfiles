#!/usr/bin/env zsh
# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice
tarsnap --list-archives |
  grep -v $(date +%Y-%m-%d) | # don't delete today's backups
  grep -v $(date -v-1d +%Y-%m-%d) | # and yesterday's
  xargs -L 1 -n 1 tarsnap -df # can't run tarsnap in parallel
