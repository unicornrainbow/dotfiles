# myfreeweb/dotfiles

## Installation
    git submodule update --init --recursive
    ./install.sh

## The good parts
- git&hg alias system, one letter == one thing, like vi commands, but the object comes before the verb, which makes more sense for version control
- [Tarsnap](http://www.tarsnap.com/)-based backup script `bin/backup` and backup deletion script `bin/rmbackups`
- `bin/pinboard_html` writes my recent [Pinboard](http://pinboard.in) bookmarks to ~/.bookmarks.html, I add it to LaunchBar, I can search it

## The weird parts
- I use the [Colemak](http://colemak.com/) keyboard layout instead of QWERTY, so in all the curses-based apps (vim, mutt, less, tmux) j and k are swapped so it's more reasonable (`k` is lower than `j` so `k` should mean down)
- on Macs, don't forget to install exuberant-ctags via [homebrew](http://mxcl.github.com/homebrew/), the built-in version isn't exuberant enough
