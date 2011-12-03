" thanks:
" http://bitbucket.org/sjl/dotfiles
" https://github.com/daveray/vimfiles
" https://github.com/erynofwales/dotfiles

syntax on
filetype off
set runtimepath+=$HOME/.vim/pathogen
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

" Settings
" basics
set nocompatible
set noequalalways
set nowrap
set expandtab
set autoindent
set encoding=utf-8
set tabstop=2 shiftwidth=2 softtabstop=2
set wrapscan nohlsearch incsearch ignorecase smartcase
set backspace=indent,eol,start
set whichwrap+=<,>,[,]
set clipboard+=unnamed
set cursorline
set noerrorbells
set hidden
set mouse=a
set completeopt=longest,menuone,preview
set autoread autowrite
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)
set laststatus=2
set backup undofile undoreload=5000
set showbreak=↪ list listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set ttyfast
set nojoinspaces
" completion
set wildmenu wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,.hg,.bzr,.svn,*.pyc,*.rbc,*.class
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac,*.pyc,*.rbc,classes,lib   " Byte code and stuff
" paths
set shell=/bin/zsh
set formatprg=par\ -eq
set tags=./tags;
set dictionary=/usr/share/dict/words
set backupskip=/tmp/*,/private/tmp/*
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set undodir=~/.vim/tmp/undo//

" Bindings
" sudo
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
" case-insensitive
cab E e
cab W w
cab Q q
cab WQ wq
cab Wq wq
inoremap jj <Esc>
" move by visual lines
nnoremap j gj
nnoremap k gk
nnoremap ; :
" emacs bindings
cnoremap <c-a> <home>
cnoremap <c-e> <end>
" plugins
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a<Space> :Tabularize /<Space><CR>
vmap <Leader>a<Space> :Tabularize /<Space><CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
map <leader>a :Ack!
nnoremap <silent> \a :set opfunc=<SID>AckMotion<CR>g@
xnoremap <silent> \a :<C-U>call <SID>AckMotion(visualmode())<CR>
function! s:CopyMotionForType(type)
    if a:type ==# 'v'
        silent execute "normal! `<" . a:type . "`>y"
    elseif a:type ==# 'char'
        silent execute "normal! `[v`]y"
    endif
endfunction
function! s:AckMotion(type) abort
    let reg_save = @@
    call s:CopyMotionForType(a:type)
    execute "normal! :Ack! --literal " . shellescape(@@) . "\<cr>"
    let @@ = reg_save
endfunction

" Das Auto
au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,Vagrantfile,Thorfile,Guardfile,config.ru} setlocal ft=ruby
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} setlocal ft=markdown
au BufRead,BufNewFile {SConstruct,SConscript,*.py} setlocal ft=python.django
au BufRead,BufNewFile *.json setlocal ft=javascript
au BufRead,BufNewFile *.conf setlocal ft=config
au BufRead,BufNewFile *.ledger setlocal ft=ledger | comp ledger
au BufRead,BufNewFile *gitconfig setlocal ft=gitconfig
au BufRead,BufNewFile *nginx.conf setlocal ft=nginx
au BufRead,BufNewFile *quakelive.cfg setlocal ft=quake
au BufRead,BufNewFile *.{css,sass,scss,less,styl} setlocal omnifunc=csscomplete#CompleteCSS
au BufRead,BufNewFile {*.go,Makefile} setlocal noexpandtab
au BufRead,BufNewFile *.{jar,war,ear,sar} setlocal ft=zip
au BufWritePost {g,.g,,.}vimrc source $MYVIMRC
au BufReadPost fugitive://* setlocal bufhidden=delete

let mapleader='\'
let maplocalleader='\'
let g:mapleader='\'
let g:CommandTMaxHeight=20
let g:user_zen_expandabbr_key='<D-e>'
let g:maintainer='{"name": "Grigory V.", "web": "http://floatboth.com"}'
let vimclojure#SplitPos="bottom"
let g:vimclojure#DynamicHighlighting=1
let g:SuperTabDefaultCompletionType = "context"

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

color solarized
set background=dark
