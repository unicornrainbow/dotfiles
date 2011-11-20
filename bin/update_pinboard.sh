#!/usr/bin/env zsh
curl http://feeds.pinboard.in/rss/u:myfreeweb/ | python $CODEDIR/dotfiles/bin/pinboard_html.py /dev/stdin > ~/.bookmarks.html
