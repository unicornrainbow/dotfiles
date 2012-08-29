# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice
#
# thanks:
# https://bitbucket.org/sjl/dotfiles/src/cbbbc897e9b3/fish/config.fish
# http://selena.deckelmann.usesthis.com/

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
set PATH (brew --prefix coreutils)/libexec/gnubin $PATH
set PATH "$DOTFILES/bin" $PATH

# Java
set -gx JAVA_HOME "/Library/Java/Home"
set PATH "/Library/Java/Home/bin" $PATH

# Fish
set -gx fish_greeting ''
set -gx COMMAND_MODE unix2003

# Less
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

function emacs
  set OLDTERM $TERM
  set -gx TERM 'xterm-256color'
  command emacs $argv
  set -gx TERM $OLDTERM
end

function latrus
  echo "$argv" | tr "qwertyuiop[]asdfghjkl;'zxcvbnm,.QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM" "йцукенгшщзхъфывапролджэячсмитьбюЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ"
end

function ruslat
  echo "$argv" | tr "йцукенгшщзхъфывапролджэячсмитьбюЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ" "qwertyuiop[]asdfghjkl;'zxcvbnm,.QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM"
end
# }}}

. $DOTFILES/python.fish
. $DOTFILES/ruby.fish

# Prompt {{{
function fish_prompt
  set last_status $status
  command fasd --proc (fasd --sanitize $1)
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

  venv_prompt
  rbenv_prompt

  if test $last_status -eq 0
    set_color green -o
    printf ' :) '
  else
    set_color red -o
    printf ' [%d] :( ' $last_status
  end
end
# }}}

bind \e\[O true
bind \e\[I true
