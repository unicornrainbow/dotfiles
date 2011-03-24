export DROPBOX=$HOME/Dropbox
export PATH=$PATH:$HOME/Dropbox/dotfiles/bin/pickdrop:$HOME/Dropbox/dotfiles/bin/rvn
export PYTHONDONTWRITEBYTECODE="yeah"
export PYTHONSTARTUP=$DROPBOX/dotfiles/pythonrc.py
export CLICOLOR="yes"

source $DROPBOX/dotfiles/zshuery/zshuery.sh
load_defaults
load_aliases
load_lol_aliases
load_completion $DROPBOX/dotfiles/zshuery/completion
load_correction

prompt '%{$fg_bold[green]%}$(COLLAPSED_DIR)%{$reset_color%}$(virtualenv_info) %{$fg[yellow]%}$(prompt_char)%{$reset_color%} '

if [ $IS_LINUX -eq 1 ]; then
    export EDITOR='emacsclient'
    export ALTERNATE_EDITOR='emacs'
    alias ls='ls '${GREP_OPTIONS}
elif [ $IS_MAC -eq 1 ]; then
    export EDITOR='aquamacs'
    export HAXE_LIBRARY_PATH="`brew --prefix`/share/haxe/std"
    source "`brew --prefix grc`/etc/grc.bashrc" # colors
fi

alias -s py=python
alias -s js=node
alias -s pl=perl
alias -s rb=ruby

vid4iphone(){ ffmpeg -i $1 -s 480x272 -b 700k "`echo $1 | awk -F . '{print $1}'`.mp4" }
source $DROPBOX/dotfiles/bin/z/z.sh

precmd () {
    local cmd type_path
    cmd=`fc -ln -1`;
    type_path="${cmd%%:*}"
    test "$LINENO" -le 1 || case "$type_path" in
        git) git clone "$cmd";;
        hg|bitbucket) hg clone "$cmd";;
	    bzr|bzr+ssh|lp) bzr branch "$cmd";;
	    http|https) wget "$cmd";;
	    file) cd "$(echo "${cmd#file://}" | ascii2uni -qa J)";;
	    *) ;;
    esac
    z --add "$(pwd -P)"
    return 0;
}
