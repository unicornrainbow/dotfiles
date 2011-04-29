syntax on

set nocompatible
set encoding=utf-8
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set list listchars=tab:\ \ ,trail:·
set nohlsearch
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
set nohidden
set shell=/bin/zsh
set mouse=a
set autochdir
set autoread
filetype off
set runtimepath+=$HOME/.vim/pathogen
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

cmap w!! w !sudo tee % >/dev/null
nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [egv
vmap <C-Down> ]egv
map  <C-h> <C-w>h
map  <C-j> <C-w>j
map  <C-k> <C-w>k
map  <C-l> <C-w>l
map  <C-c> <Leader>c 

au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,Vagrantfile,Thorfile,config.ru} set ft=ruby
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} set ft=markdown
au BufRead,BufNewFile {SConstruct,SConscript,*.py} set ft=python.django
au BufRead,BufNewFile *.json set ft=javascript
au bufwritepost .vimrc source $MYVIMRC

let mapleader = ","
let g:mapleader = ","
let g:CommandTMaxHeight=20
let g:user_zen_expandabbr_key='<D-e>'
let g:jekyll_path='~/Dropbox/work/floatboth'
let g:maintainer='{"name": "Grigory V.", "web": "http://myfreeweb.ru"}'

if filereadable(expand("~/.vimrc.local"))
	source ~/.vimrc.local
endif

color solarized
