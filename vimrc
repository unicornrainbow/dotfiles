" thanks:
" http://bitbucket.org/sjl/dotfiles
" https://github.com/daveray/vimfiles
" https://github.com/erynofwales/dotfiles
" https://github.com/rmurphey/dotfiles
" https://github.com/holman/dotfiles
" https://github.com/spf13/spf13-vim

set nocompatible
set runtimepath+=$HOME/.vim/pathogen
call pathogen#helptags()
call pathogen#infect()
filetype plugin indent on
syntax on

" basics {{{
set noswapfile backup undofile undoreload=5000 history=500
set noequalalways
set wrapscan incsearch ignorecase smartcase
set clipboard+=unnamed
set autoread autowrite
set magic
set nojoinspaces
set modelines=3
" }}}
" formatting {{{
set nowrap
set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2
set autoindent smartindent
set encoding=utf-8 nobomb
set whichwrap+=<,>,[,]
set virtualedit=block
" }}}
" ui {{{
set nohlsearch
set backspace=indent,eol,start
set noerrorbells
set showbreak=↪
set list listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set fillchars+=vert:│
set ttyfast title
set cursorline
set hidden
set mouse=a
set shortmess=filtIoOA
set laststatus=2
set nostartofline
set visualbell
set showmatch
set mat=5
set virtualedit=onemore
set viewoptions=folds,options,cursor,unix,slash
" }}}
" completion {{{
set completeopt=longest,menuone,preview
set wildmenu wildmode=list:longest,list:full
set wildignore+=.hg,.git,.bzr,.svn                 " Version control
set wildignore+=*.aux,*.out,*.toc                  " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg     " binary images
set wildignore+=*.luac,*.pyc,*.rbc,*.class,classes " Byte code and stuff
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest   " compiled object files
set wildignore+=*.spl                              " compiled spelling word lists
set wildignore+=*.sw?                              " Vim swap files
set wildignore+=.DS_Store,Thumbs.db                " Shit
" }}}
" paths {{{
set shell=/bin/zsh
set formatprg=par\ -eq
set tags=./tags;
set dictionary=/usr/share/dict/words
set backupskip=/tmp/*,/private/tmp/*
set backupdir=~/.vim/tmp/backups/
set undodir=~/.vim/tmp/undo/
" }}}

" Bindings
" stuff {{{
noremap k gj
noremap j gk
noremap ' i
noremap U <C-r>
cmap w!! w !sudo tee % >/dev/null
nnoremap ; :
nnoremap <Space> za
vnoremap <Space> za
noremap! <C-Y> <Esc>klyWjpa
map <Leader><CR> o<ESC>
nnoremap Y y$
nnoremap <CR> zvzz " center line
" }}}
" moving lines around {{{
vmap <C-Up> [egv
vmap <C-Down> ]egv
" }}}
" windows {{{
map  <C-h> <C-w>h
map  <C-k> <C-w>j
map  <C-j> <C-w>k
map  <C-l> <C-w>l
" }}}
" case-insensitive {{{
cab E e
cab W w
cab Q q
cab WQ wq
cab Wq wq
" }}}
" emacs bindings {{{
inoremap <C-a> <home>
inoremap <C-e> <end>
" }}}
" indent block {{{
nnoremap <Leader>] >i{<CR>
nnoremap <Leader>[ <i{<CR>
" }}}
" buffer nav {{{
map <Right> :bnext<CR>
map <Left>  :bprev<CR>
" }}}
" plugins {{{
nmap <Leader>T= :Tabularize /=<CR>
vmap <Leader>T= :Tabularize /=<CR>
nmap <Leader>T<Space> :Tabularize /<Space><CR>
vmap <Leader>T<Space> :Tabularize /<Space><CR>
nmap <Leader>T: :Tabularize /:\zs<CR>
vmap <Leader>T: :Tabularize /:\zs<CR>
nmap sj :SplitjoinSplit<CR>
nmap sk :SplitjoinJoin<CR>
map <Leader>A :Ack! 
nnoremap <silent> <Leader>a :set opfunc=<SID>AckMotion<CR>g@
xnoremap <silent> <Leader>a :<C-U>call <SID>AckMotion(visualmode())<CR>
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
nnoremap <leader>w :silent !open <C-R>=escape("<C-R><C-F>", "#?&;\|%")<CR><CR>
" }}}

" Das Auto {{{
au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,Vagrantfile,Thorfile,Guardfile,config.ru} setf ruby
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,ronn} setf markdown
au BufRead,BufNewFile {SConstruct,SConscript,*.py} setf python.django
au BufRead,BufNewFile *.{nu,nujson},Nukefile setf nu
au BufRead,BufNewFile *.json setf javascript
au BufRead,BufNewFile *.conf setf config
au BufRead,BufNewFile *.ledger setf ledger | comp ledger
au BufRead,BufNewFile *gitconfig setf gitconfig
au BufRead,BufNewFile nginx.conf setf nginx
au BufRead,BufNewFile *.gradle setf groovy
au BufRead,BufNewFile *.muttrc setf muttrc
au BufRead,BufNewFile quakelive.cfg setf quake
au BufRead,BufNewFile *.{css,sass,scss,less,styl} setlocal omnifunc=csscomplete#CompleteCSS
au BufRead,BufNewFile {*.go,Makefile} setlocal noexpandtab
au BufRead,BufNewFile *.{jar,war,ear,sar} setf zip
au BufRead,BufNewFile {,.}zshrc setlocal foldmethod=marker
au BufWritePost {g,.g,,.}vimrc source $MYVIMRC
au BufReadPost fugitive://* setlocal bufhidden=delete
au VimResized * exe "normal! \<c-w>="
au FileType vim setlocal foldmethod=marker
au FileType help setlocal textwidth=78
au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
" }}}

" Vars {{{
let mapleader=','
let maplocalleader=','
let g:mapleader=','
let g:CommandTMaxHeight=20
let g:maintainer='{"name": "Grigory V.", "web": "http://floatboth.com"}'
let vimclojure#SplitPos='bottom'
let g:vimclojure#DynamicHighlighting=1
let g:SuperTabDefaultCompletionType='context'
let g:Powerline_symbols='fancy'
let delimitMate_excluded_ft='clojure'
" }}}

set background=light
if $SOLARIZED != ""
  set background="{$SOLARIZED}"
endif
colorscheme solarized

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
