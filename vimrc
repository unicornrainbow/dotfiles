" thanks:
" http://bitbucket.org/sjl/dotfiles

syntax on

filetype off
set runtimepath+=$HOME/.vim/pathogen
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

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
set autoread
set autowrite
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)
set laststatus=2
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set backup
set undofile
set undoreload=5000

cmap w!! w !sudo tee % >/dev/null
nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [egv
vmap <C-Down> ]egv
map  <C-h> <C-w>h
map  <C-j> <C-w>j
map  <C-k> <C-w>k
map  <C-l> <C-w>l
map  <Leader>a :Ack!
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" change case
nnoremap <C-u> gUiw
inoremap <C-u> <esc>gUiwea
" textmate-style formatting
nnoremap <Leader>q gqip

au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,Vagrantfile,Thorfile,Guardfile,config.ru} set ft=ruby
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} set ft=markdown
au BufRead,BufNewFile {SConstruct,SConscript,*.py} set ft=python.django
au BufRead,BufNewFile *.json set ft=javascript
au BufRead,BufNewFile *.conf set ft=config
au BufRead,BufNewFile *.{css,sass,scss,less,styl} set omnifunc=csscomplete#CompleteCSS
au BufRead,BufNewFile *.{sass,scss,less,styl} runtime! after/syntax/css.vim
au BufRead,BufNewFile *.go set noexpandtab
au BufReadCmd *.jar call zip#Browse(expand('<amatch>'))
au BufWritePost {g,.g,,.}vimrc source $MYVIMRC
au BufReadPost fugitive://* set bufhidden=delete

let mapleader=','
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
