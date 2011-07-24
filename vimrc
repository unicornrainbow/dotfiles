" thanks:
" http://bitbucket.org/sjl/dotfiles
" https://github.com/daveray/vimfiles

syntax on

filetype off
set runtimepath+=$HOME/.vim/pathogen
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

set nocompatible
set encoding=utf-8
set nowrap
set tabstop=2 shiftwidth=2 softtabstop=2
set expandtab
set autoindent
set list listchars=tab:\ \ ,trail:·
set wrapscan nohlsearch incsearch ignorecase smartcase
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,.hg,.bzr,.svn,*.pyc,*.rbc,*.class
set backupskip=/tmp/*,/private/tmp/*
set noequalalways
set backspace=indent,eol,start
set whichwrap+=<,>,[,]
set clipboard+=unnamed
set cursorline
set noerrorbells
set hidden
set shell=/bin/zsh
set mouse=a
set completeopt=longest,menuone,preview
set tags=./tags;
set autoread autowrite
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)
set laststatus=2
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set backup undofile undoreload=5000

cmap w!! w !sudo tee % >/dev/null
" moving lines around
nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [egv
vmap <C-Down> ]egv
map  <C-h> <C-w>h
map  <C-j> <C-w>j
map  <C-k> <C-w>k
map  <C-l> <C-w>l
" you know what
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a<Space> :Tabularize /<Space><CR>
  vmap <Leader>a<Space> :Tabularize /<Space><CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif
" change case
nnoremap <C-u> gUiw
inoremap <C-u> <esc>gUiwea
" textmate-style formatting
nnoremap <Leader>q gqip
" shift shit
cab W w
cab Q q

au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,Vagrantfile,Thorfile,Guardfile,config.ru} set ft=ruby
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} set ft=markdown
au BufRead,BufNewFile {SConstruct,SConscript,*.py} set ft=python.django
au BufRead,BufNewFile *.json set ft=javascript
au BufRead,BufNewFile *.conf set ft=config
au BufRead,BufNewFile *nginx.conf set ft=nginx
au BufRead,BufNewFile *quakelive.cfg set ft=quake
au BufRead,BufNewFile *.{css,sass,scss,less,styl} set omnifunc=csscomplete#CompleteCSS
au BufRead,BufNewFile {*.go,Makefile} set noexpandtab
au BufReadCmd *.jar call zip#Browse(expand('<amatch>'))
au BufWritePost {g,.g,,.}vimrc source $MYVIMRC
au BufReadPost fugitive://* set bufhidden=delete
au FileType markdown set linebreak

let mapleader=','
let maplocalleader=','
let g:mapleader=','
let g:CommandTMaxHeight=20
let g:user_zen_expandabbr_key='<D-e>'
let g:maintainer='{"name": "Grigory V.", "web": "http://floatboth.com"}'
let vimclojure#WantNailgun=1
let vimclojure#SplitPos="bottom"
let g:vimclojure#DynamicHighlighting=1

if filereadable(expand("~/.vimrc.local"))
	source ~/.vimrc.local
endif

color solarized
