export CODEDIR=$HOME/Code
export PYTHONDONTWRITEBYTECODE="yeah"
export PYTHONSTARTUP=$CODEDIR/dotfiles/pythonrc.py
export CLICOLOR="yes"
export EDITOR="vim"

for dir in $CODEDIR/dotfiles/bin/*; export PATH=$PATH:$dir
export PATH=$CODEDIR/dotfiles/bin:$CODEDIR:/usr/local/bin:/usr/local/sbin:.cljr/bin:$PATH
source $CODEDIR/dotfiles/zshuery/zshuery.sh
source $CODEDIR/dotfiles/bin/z/z.sh

load_defaults
load_aliases
load_lol_aliases
load_completion $CODEDIR/dotfiles/zshuery/completion
load_correction

prompts '%{$fg_bold[green]%}$(COLLAPSED_DIR)%{$reset_color%}$(virtualenv_info) %{$fg[yellow]%}$(prompt_char)%{$reset_color%} ' '%{$fg[red]%}$(ruby_version)%{$reset_color%}'
if [[ $IS_LINUX -eq 1 ]]; then
    alias ls="ls "${GREP_OPTIONS}
elif [[ $IS_MAC -eq 1 ]]; then
    export HAXE_LIBRARY_PATH="`brew --prefix`/share/haxe/std"
    source "`brew --prefix grc`/etc/grc.bashrc"
    export GOROOT=`brew --prefix go`
    export GOBIN=$GOROOT/bin
    export PATH=$GOBIN:$PATH
    [[ -e /usr/local/lib/stderred.so ]] && export DYLD_INSERT_LIBRARIES=/usr/local/lib/stderred.so DYLD_FORCE_FLAT_NAMESPACE=1
fi

bindkey -e

alias -s py=python
alias -s js=node
alias -s rb=ruby
alias -s coffee=coffee
alias rmswp="rm ~/.vim/tmp/swap/*"
alias v="vim ."
alias l="ls"
alias gs="git s"
alias "ps?"="ps aux | ack"

chpwd() {
    update_terminal_cwd
}

precmd() {
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

source $CODEDIR/dotfiles/vendor/zsh-hl/zsh-syntax-highlighting.zsh
source $CODEDIR/dotfiles/vendor/zsh-hss/zsh-history-substring-search.zsh

export PATH=$HOME/.rbenv/shims:/usr/local/bin:$PATH # WTF
export LEDGER_FILE=$HOME/Documents/my.ledger
alias ele="vim $LEDGER_FILE"

source $HOME/.zshrc.local
