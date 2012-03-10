# Variables {{{
export CODEDIR=$HOME/Code
if [[ -e $HOME/.dotfiles_location ]]; then
  export DOTFILES=$(cat $HOME/.dotfiles_location)
else
  export DOTFILES=$HOME/Code/dotfiles
  echo "~/.dotfiles_location not found, reinstall dotfiles"
fi
export PYTHONDONTWRITEBYTECODE="yeah"
export PYTHONSTARTUP=$DOTFILES/pythonrc.py
export CLICOLOR="yes"
export EDITOR="vim"
export PAGER="less"
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[38;5;246m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;33;146m'
export LESS="-mNR"
export LANG="en_US.UTF-8"
export LEDGER_FILE=$HOME/Documents/my.ledger
# }}}
# Loading plugins, setting PATH {{{
if [[ $SETPATH -ne 1 ]]; then
  for dir in $DOTFILES/bin/*(/); do
    export PATH=$dir:$PATH
  done
  [[ -d /opt/gradle    ]] && export PATH=/opt/gradle/bin:$PATH
  [[ -d /opt/reply     ]] && export PATH=/opt/reply/bin:$PATH
  [[ -d /opt/kindlegen ]] && export PATH=/opt/kindlegen:$PATH
  [[ -d /opt/gae_go    ]] && export GOROOT=/opt/gae_go/goroot \
    && export GOBIN=$GOROOT/bin && export PATH=/opt/gae_go:$GOBIN:$PATH
  [[ $IS_MAC -eq 1 ]] && BREWGO=$(brew --prefix go) && \
    [[ -d $BREWGO ]] && export GOROOT=$BREWGO && export GOBIN=$BREWGO/bin \
    && export GOPATH=$GOROOT && export PATH=$GOBIN:$PATH
  export PATH=$DOTFILES/bin:/usr/local/bin:/usr/local/sbin:$HOME/.cljr/bin:$PATH
  export SETPATH=1
fi

source $DOTFILES/bin/z/z.sh
source $DOTFILES/vendor/zsh-hl/zsh-syntax-highlighting.zsh
source $DOTFILES/zshuery/zshuery.sh

load_defaults
load_aliases
load_lol_aliases
load_completion $DOTFILES/zshuery/completion
load_correction
# }}}
# Custom settings, aliases and functions {{{
if [[ $IS_MAC -eq 1 ]]; then
  export HAXE_LIBRARY_PATH="$(brew --prefix)/share/haxe/std"
  source "$(brew --prefix grc)/etc/grc.bashrc"
  [[ -e /usr/local/lib/stderred.so ]] && export DYLD_INSERT_LIBRARIES=/usr/local/lib/stderred.so DYLD_FORCE_FLAT_NAMESPACE=1
  alias nolib="DYLD_INSERT_LIBRARIES= "
  alias cabal="nolib cabal"
  alias kindlegen="nolib kindlegen"
fi

alias rmswp="rm ~/.vim/tmp/swap/*"
alias collapse="sed -e 's/  */ /g'"
alias v="vim"
alias l="ls"
alias g="git"
alias p="popd"
alias r="rails"
alias ci="git commit -am"
alias gaes="dev_appserver.py -a 0.0.0.0 ."
psack() {
  ps auxww | ack $* | ack -v ack | collapse | cut -d' ' -f 2,11-
}
alias "ps?"=psack
alias P="$PAGER"

alias ele="$EDITOR $LEDGER_FILE"
alias ass="ledger -s bal Assets"
ale() {
  echo "\n$(date +%m/%d) $1\n    $2    $3 RUR\n    $4" >> $LEDGER_FILE
}
alea() { ale $1 Expenses:Apps $2 Assets:QIWI }
aleg() { ale $1 Expenses:Games $2 Assets:QIWI }
aleq() { ale "QIWI adding" Assets:QIWI $1 $2 }
aleqa(){ aleq $1 Assets:Wallet }
cljv() {
  curl -s clojars.org/$1 | grep version | sed -e "s/<[a-z\/=\" ]*>//g" -e "s/&lt;[\/a-z]*&gt;//g"
}

chpwd() {
  update_terminal_cwd
  z --add "$(pwd -P)"
}

prompts '%{$fg_bold[green]%}$(COLLAPSED_DIR)%{$reset_color%}$(virtualenv_info) %{$fg[yellow]%}$(prompt_char)%{$reset_color%} ' '%{$fg[red]%}$(ruby_version)%{$reset_color%}'
setopt auto_pushd
bindkey -e

source $DOTFILES/vendor/zsh-hss/zsh-history-substring-search.zsh
source $HOME/.zshrc.local
# }}}
