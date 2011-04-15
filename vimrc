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

cmap w!! w !sudo tee % >/dev/null
nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [egv
vmap <C-Down> ]egv

au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,Vagrantfile,Thorfile,config.ru} set ft=ruby
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} set ft=markdown
au FileType python set textwidth=79

filetype off
set runtimepath+=$HOME/.vim/pathogen
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

if has("autocmd")
  autocmd FileType python set ft=python.django
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

let mapleader = ","
let g:CommandTMaxHeight=20
let g:user_zen_expandabbr_key='<D-e>'
let g:jekyll_path='~/Dropbox/work/floatboth'

if filereadable(expand("~/.vimrc.local"))
	source ~/.vimrc.local
endif

color solarized
