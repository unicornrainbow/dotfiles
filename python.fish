# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice
#
# thanks: 
# http://coderseye.com/2010/using-virtualenv-with-fish-shell.html

set -gx PYTHONPATH "/usr/local/lib/python2.7/site-packages:$PYTHONPATH"
set -gx PYTHONDONTWRITEBYTECODE true
set -gx VIRTUALENV_DISTRIBUTE true
set -gx PIP_USE_MIRRORS true
set -gx PYTHONSTARTUP "$DOTFILES/pythonrc.py"
set -gx WORKON_HOME "$CODEDIR"

function venv_prompt
  if [ -n "$VIRTUAL_ENV" ]
    set_color cyan
    printf ' (%s)' (basename "$VIRTUAL_ENV")
    set_color normal
  end
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
