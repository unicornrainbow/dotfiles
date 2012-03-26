# myfreeweb/dotfiles

## Installation
    git submodule update --init --recursive
    ./install.sh

## Dependencies
There are many. And most of them can be installed with [babushka](http://babushka.me/) + my [deps](https://github.com/myfreeweb/babushka-deps). Hey, it even installs the dotfiles themselves.

But are you really going to use all my dotfiles? No. You're not me. You should steal the good parts instead :-)

## The good parts
- git&hg alias system, one letter == one thing, like vi commands, but the object comes before the verb, which makes more sense for version control
- extremely awesome `irb` (ruby), `python`, `lein` (clojure), `re.pl` (perl) configs
- [powerline](https://github.com/Lokaltog/vim-powerline) in vim and a similar thing for tmux, stolen from [sjl/dotfiles](https://github.com/sjl/dotfiles/), but with keyboard layout instead of music and mail. cool if you're bilingual. customize `bin/keylayout.sh` for your language if it's not russian.
- [Tarsnap](http://www.tarsnap.com/)-based backup script `bin/backup.sh` and backup deletion script `bin/rmbackups.sh`
- `bin/pinboard_html.py` writes my recent [Pinboard](http://pinboard.in) bookmarks to ~/.bookmarks.html, I add it to LaunchBar, I can search it
- solid, robust, UNIX-way mail configuration: mutt + offlineimap + msmtp + notmuch + urlview + `bin/addressbook.py` work together. like a boss!
- zsh from the future! [zshuery](https://github.com/myfreeweb/zshuery), [history search](https://github.com/zsh-users/zsh-history-substring-search) and [syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

## The weird parts
- I use the [Colemak](http://colemak.com/) keyboard layout instead of QWERTY, so in all the curses-based apps (vim, mutt, less, tmux) j and k are swapped so it's more reasonable (`k` is lower than `j` so `k` should mean down)
- on Macs, don't forget to install exuberant-ctags via [homebrew](http://mxcl.github.com/homebrew/), the built-in version isn't exuberant enough