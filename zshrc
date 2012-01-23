export CODEDIR=$HOME/Code
export PYTHONDONTWRITEBYTECODE="yeah"
export PYTHONSTARTUP=$CODEDIR/dotfiles/pythonrc.py
export CLICOLOR="yes"
export EDITOR="vim"
export PAGER="less"

for dir in $CODEDIR/dotfiles/bin/*; export PATH=$dir:$PATH
source $CODEDIR/dotfiles/zshuery/zshuery.sh
source $CODEDIR/dotfiles/bin/z/z.sh
load_defaults
load_aliases
load_lol_aliases
load_completion $CODEDIR/dotfiles/zshuery/completion
load_correction

prompts '%{$fg_bold[green]%}$(COLLAPSED_DIR)%{$reset_color%}$(virtualenv_info) %{$fg[yellow]%}$(prompt_char)%{$reset_color%} ' '%{$fg[red]%}$(ruby_version)%{$reset_color%}'
setopt auto_pushd
bindkey -e

if [[ $IS_LINUX -eq 1 ]]; then
    alias ls="ls "${GREP_OPTIONS}
elif [[ $IS_MAC -eq 1 ]]; then
    export HAXE_LIBRARY_PATH="$(brew --prefix)/share/haxe/std"
    source "$(brew --prefix grc)/etc/grc.bashrc"
    export GOROOT=$(brew --prefix go)
    export GOBIN=$GOROOT/bin
    [[ -e /usr/local/lib/stderred.so ]] && export DYLD_INSERT_LIBRARIES=/usr/local/lib/stderred.so DYLD_FORCE_FLAT_NAMESPACE=1
    alias nolib="DYLD_INSERT_LIBRARIES= "
    alias cabal="nolib cabal"
fi

alias rmswp="rm ~/.vim/tmp/swap/*"
alias collapse="sed -e 's/  */ /g'"
alias v="vim"
alias l="ls"
alias g="git"
alias t="todo.sh -d $CODEDIR/dotfiles/todo.cfg"
alias p="popd"
alias ci="git commit -am"
psack() {
  ps auxww | ack $* | ack -v ack | collapse | cut -d' ' -f 2,11-
}
alias "ps?"=psack
alias P="$PAGER"

export LEDGER_FILE=$HOME/Documents/my.ledger
alias ele="$EDITOR $LEDGER_FILE"
alias ass="ledger -s bal Assets"
ale() {
  echo "\n$(date +%m/%d) $1\n    $2    $3 RUR\n    $4" >> $LEDGER_FILE
}
alea() { ale $1 Expenses:Apps $2 Assets:QIWI }
aleg() { ale $1 Expenses:Games $2 Assets:QIWI }

source $CODEDIR/dotfiles/vendor/zsh-hl/zsh-syntax-highlighting.zsh
source $CODEDIR/dotfiles/vendor/zsh-hss/zsh-history-substring-search.zsh
export PATH=$HOME/.rbenv/shims:$GOBIN:$CODEDIR/dotfiles/bin:$CODEDIR:/usr/local/bin:/usr/local/sbin:$HOME/.cljr/bin:$PATH
[[ -e /opt/gradle ]] && export PATH="/opt/gradle:$PATH"


chpwd() {
  update_terminal_cwd
  z --add "$(pwd -P)"
}

precmd() {
  local cmd type_path
  cmd=`fc -ln -1`;
  type_path="${cmd%%:*}"
  test "$LINENO" -le 1 || case "$type_path" in
    git) git clone "$cmd";;
    hg|bitbucket) hg clone "$cmd";;
    http|https) wget "$cmd";;
    file) cd "$(echo "${cmd#file://}" | ascii2uni -qa J)";;
    *) ;;
  esac
  return 0;
}

source $HOME/.zshrc.local
