autoload zcalc

export DROPBOX=$HOME/Dropbox
export ZSH=$DROPBOX/dotfiles/oh-my-zsh
export ZSH_THEME="myfreeweb"

plugins=(git github ruby gem pip fabric osx command-not-found command-coloring)

source $ZSH/oh-my-zsh.sh
export PYTHONDONTWRITEBYTECODE="yeah"
export DISABLE_AUTO_UPDATE="true"
export CLICOLOR="yes"
if [[ $(uname) = 'Linux' ]]; then
    export EDITOR='emacsclient'
    export ALTERNATE_EDITOR='emacs'
elif [[ $(uname) = 'Darwin' ]]; then
    export EDITOR='aquamacs'
fi

if [[ -x `which hub` ]]; then
    eval $(hub alias -s zsh)
fi
if [[ -d /var/lib/gems/1.8/bin ]]; then
    export PATH=$PATH:/var/lib/gems/1.8/bin
fi
if [[ $(uname) = 'Linux' ]]; then
    alias ls='ls '${GREP_OPTIONS}
fi
alias la='ls -la'
alias df='df -h'
alias du='du -h'
alias erl='nocorrect erl'
alias curl='nocorrect curl'
alias rake='nocorrect rake'
alias make='nocorrect make'
alias cake='nocorrect cake'
alias lessc='nocorrect lessc'
alias pinst='sudo python setup.py install && sudo rm -r build/ && sudo rm -r dist && sudo rm -r *egg-info'
alias moar='more'
alias -s py=python
alias -s js=node
alias -s pl=perl
alias -s rb=ruby

#Stuff
vid4iphone(){ ffmpeg -i $1 -s 480x272 -b 700k "`echo $1 | awk -F . '{print $1}'`.mp4" }
md5(){ echo $1 | openssl md5 /dev/stdin }
sha1(){ echo $1 | openssl sha1 /dev/stdin }
mcd(){ mkdir $1; cd $1 }
if [[ $(uname) = 'Darwin' ]]; then
    source "`brew --prefix grc`/etc/grc.bashrc" # colors
    gimme(){ sudo brew install $1 }
elif [[ $(uname) = 'Linux' ]]; then
    gimme(){ sudo apt-get install $1 }
fi
source $ZSH/z/z.sh

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
