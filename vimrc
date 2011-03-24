syntax on

set nocompatible
set encoding=utf-8
set nowrap
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set list listchars=tab:\ \ ,trail:·
set hlsearch
set incsearch
set ignorecase
set smartcase
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,.hg,.bzr,.svn,*.pyc,*.rbc
set noequalalways
set backspace=indent,eol,start
set whichwrap+=<,>,[,]
set clipboard+=unnamed
set cursorline
set noerrorbells
set shell=/bin/zsh

let g:CommandTMaxHeight=20
let g:molokai_original = 1

cmap w!! w !sudo tee % >/dev/null

au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,Vagrantfile,Thorfile,config.ru} set ft=ruby
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} set ft=markdown
au FileType python set textwidth=79

filetype off
set runtimepath+=$HOME/.vim/pathogen
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

autocmd FileType python set ft=python.django
let g:user_zen_expandabbr_key='<D-e>'
let g:jekyll_path='~/Dropbox/work/floatboth'

if filereadable(expand("~/.vimrc.local"))
	source ~/.vimrc.local
endif

color molokai
