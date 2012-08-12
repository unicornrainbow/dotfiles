# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice
#
# thanks:
# https://bitbucket.org/sjl/dotfiles/src/cbbbc897e9b3/fish/config.fish
# http://selena.deckelmann.usesthis.com/
# http://coderseye.com/2010/using-virtualenv-with-fish-shell.html

# Setting env {{{
set CODEDIR $HOME/Code
if test -s $HOME/.dotfiles_location
  set DOTFILES (cat $HOME/.dotfiles_location)
else
  set DOTFILES $CODEDIR/dotfiles
  echo "~/.dotfiles_location not found, reinstall dotfiles"
end

set PATH "/usr/local/bin" $PATH
set PATH "/usr/local/sbin" $PATH
for dir in $DOTFILES/bin/*/
  set PATH $dir $PATH
end
set PATH "$DOTFILES/bin" $PATH

# Python
set -gx PYTHONPATH "/usr/local/lib/python2.7/site-packages:$PYTHONPATH"
set -gx PYTHONDONTWRITEBYTECODE true
set -gx VIRTUALENV_DISTRIBUTE true
set -gx PIP_USE_MIRRORS true
set -gx PYTHONSTARTUP "$DOTFILES/pythonrc.py"
set -gx WORKON_HOME "$CODEDIR"

# Ruby
set -gx RUBY_HEAP_MIN_SLOTS 1000000
set -gx RUBY_HEAP_SLOTS_INCREMENT 1000000
set -gx RUBY_HEAP_SLOTS_GROWTH_FACTOR 1
set -gx RUBY_GC_MALLOC_LIMIT 1000000000
set -gx RUBY_HEAP_FREE_MIN 500000
set PATH "$HOME/.rbenv/bin" $PATH
set PATH "$HOME/.rbenv/shims" $PATH
rbenv rehash 2>/dev/null

# Java
set -gx JAVA_HOME "/Library/Java/Home"
set PATH "/Library/Java/Home/bin" $PATH

# Fish
set -gx fish_greeting ''
set -gx COMMAND_MODE unix2003

# Less
set -gx LESS_TERMCAP_mb '\E[01;31m'
set -gx LESS_TERMCAP_me '\E[0m'
set -gx LESS_TERMCAP_se '\E[0m'
set -gx LESS_TERMCAP_so '\E[38;5;246m'
set -gx LESS_TERMCAP_ue '\E[0m'
set -gx LESS_TERMCAP_us '\E[04;33;146m'
set -gx LESS "-R"

# Generic settings
set -gx CLICOLOR "yes"
set -gx EDITOR "vim"
set -gx PAGER "less"
set -gx LANG "en_US.UTF-8"
set -gx LC_ALL "en_US.UTF-8"
set -gx LEDGER_FILE "$HOME/Documents/my.ledger"
# }}}

# Functions {{{
. $DOTFILES/rc
alias z 'pushd (fasd -d $argv)'

function mcd
  mkdir -p "$argv"
  cd "$argv"
end

function latrus
  echo "$argv" | tr "qwertyuiop[]asdfghjkl;'zxcvbnm,.QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM" "йцукенгшщзхъфывапролджэячсмитьбюЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ"
end

function ruslat
  echo "$argv" | tr "йцукенгшщзхъфывапролджэячсмитьбюЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ" "qwertyuiop[]asdfghjkl;'zxcvbnm,.QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM"
end

# Virtualenv
function workon -d "Activate virtual environment in $WORKON_HOME"
  set tgt {$WORKON_HOME}/$argv[1]

  if [ ! -d $tgt ]
    mkdir -p "$WORKON_HOME"
    virtualenv $tgt/venv
  end

  if [ -d $tgt ]
    cd $tgt

    deactivate

    set -gx VIRTUAL_ENV "$tgt/venv"
    set -gx _OLD_VIRTUAL_PATH $PATH
    set -gx PATH "$VIRTUAL_ENV/bin" $PATH

    # unset PYTHONHOME if set
    if set -q PYTHONHOME
       set -gx _OLD_VIRTUAL_PYTHONHOME $PYTHONHOME
       set -e PYTHONHOME
    end

    echo "activated $tgt"
  else
    echo "$tgt not found"
  end
end

complete -c workon -a "(cd $WORKON_HOME; ls -d *)"

function deactivate -d "Exit virtualenv and return to normal shell environment"
    # reset old environment variables
    if test -n "$_OLD_VIRTUAL_PATH"
        set -gx PATH $_OLD_VIRTUAL_PATH
        set -e _OLD_VIRTUAL_PATH
    end
    if test -n "$_OLD_VIRTUAL_PYTHONHOME"
        set -gx PYTHONHOME $_OLD_VIRTUAL_PYTHONHOME
        set -e _OLD_VIRTUAL_PYTHONHOME
    end
    set -e VIRTUAL_ENV
end
# }}}

# Prompt {{{
function fish_prompt
  command fasd --proc (fasd --sanitize $1)
  set last_status $status
  echo

  set_color black
  printf '%s' (prompt_pwd)
  set_color normal

  if git rev-parse --show-toplevel >/dev/null 2>&1
    set_color normal
    printf ' on '
    set_color magenta
    printf '%s' (git branch --contains HEAD ^/dev/null | grep '*' | tr -s ' ' | cut -d ' ' -f2)
    set_color normal
  end

  if [ -n "$VIRTUAL_ENV" ]
    set_color cyan
    printf ' (%s)' (basename "$VIRTUAL_ENV")
    set_color normal
  end

  if test -s $HOME/.rbenv/version
    set_color red
    printf ' <%s>' (cat $HOME/.rbenv/version)
    set_color normal
  end

  if test $last_status -eq 0
    set_color green -o
    printf ' :) '
  else
    set_color red -o
    printf ' [%d] :( ' $last_status
  end
end
# }}}

if status --is-interactive
  command fortune -s | cowsay -n | lolcat
end
