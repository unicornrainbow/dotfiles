#!/usr/bin/env zsh
# This came from http://pbrisbin.com/posts/mutt_gmail_offlineimap
# Modified for using standard unix tools instead of pgrep

PID=$(ps ax | awk '/[o]fflineimap/ {print $1}' | head -n 1)

# the only time offlineimap has been still running after 3 minutes for 
# me is if it's frozen... we'll kill it and resync
[[ -n "$PID" ]] && kill $PID

offlineimap -o -u quiet &>/dev/null &

exit 0
