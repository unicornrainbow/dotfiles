export CODEDIR=$HOME/Code
export PYTHONDONTWRITEBYTECODE="yeah"
export PYTHONSTARTUP=$CODEDIR/dotfiles/pythonrc.py
export CLICOLOR="yes"

for dir in $CODEDIR/dotfiles/bin/*; export PATH=$PATH:$dir
export PATH=/usr/local/sbin:$PATH:~/.cljr/bin

source $CODEDIR/dotfiles/zshuery/zshuery.sh
load_defaults
load_aliases
load_lol_aliases
load_completion $CODEDIR/dotfiles/zshuery/completion
load_correction

prompts '%{$fg_bold[green]%}$(COLLAPSED_DIR)%{$reset_color%}$(virtualenv_info) %{$fg[yellow]%}$(prompt_char)%{$reset_color%} ' '%{$fg[red]%}$(ruby_version)%{$reset_color%}'
if [[ $IS_LINUX -eq 1 ]]; then
    alias ls='ls '${GREP_OPTIONS}
elif [[ $IS_MAC -eq 1 ]]; then
    export HAXE_LIBRARY_PATH="`brew --prefix`/share/haxe/std"
    source "`brew --prefix grc`/etc/grc.bashrc"
    export GOROOT=`brew --prefix go`
fi
export EDITOR='vim'
bindkey -e

alias -s py=python
alias -s js=node
alias -s pl=perl
alias -s rb=ruby
alias -s coffee=coffee

source $CODEDIR/dotfiles/bin/z/z.sh

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
    if [[ -d "$(pwd)/src" ]]; then
      CLOJURE_SOURCE_DIRS=`pwd`/lib:`pwd`/src
    fi
    z --add "$(pwd -P)"
    return 0;
}
