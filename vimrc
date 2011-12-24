" thanks:
" http://bitbucket.org/sjl/dotfiles
" https://github.com/daveray/vimfiles
" https://github.com/erynofwales/dotfiles
" https://github.com/rmurphey/dotfiles

set nocompatible
set runtimepath+=$HOME/.vim/pathogen
call pathogen#helptags()
call pathogen#infect()
filetype plugin indent on
syntax on

" basics
set noequalalways
set nowrap
set expandtab
set autoindent
set encoding=utf-8 nobomb
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
set noswapfile backup undofile undoreload=5000 history=500
set showbreak=↪ list listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set ttyfast title
set nojoinspaces
set magic
" completion
set wildmenu wildmode=list:longest,list:full
set wildignore+=.hg,.git,.bzr,.svn                 " Version control
set wildignore+=*.aux,*.out,*.toc                  " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg     " binary images
set wildignore+=*.luac,*.pyc,*.rbc,*.class,classes " Byte code and stuff
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest   " compiled object files
set wildignore+=*.spl                              " compiled spelling word lists
set wildignore+=*.sw?                              " Vim swap files
set wildignore+=.DS_Store,Thumbs.db                " Shit
" paths
set shell=/bin/zsh
set formatprg=par\ -eq
set tags=./tags;
set dictionary=/usr/share/dict/words
set backupskip=/tmp/*,/private/tmp/*
set backupdir=~/.vim/tmp/backup//
set undodir=~/.vim/tmp/undo//

" Bindings
" colemak movement and stuff
noremap n gj
noremap e gk
noremap i l
nnoremap ; :
noremap f e
noremap k n
noremap K N
noremap u i
noremap l u
noremap L <C-r>
cmap w!! w !sudo tee % >/dev/null
inoremap nn <Esc>
" moving lines around
vmap <C-Up> [egv
vmap <C-Down> ]egv
" windows
map  <C-h> <C-w>h
map  <C-n> <C-w>j
map  <C-e> <C-w>k
map  <C-i> <C-w>l
" case-insensitive
cab E e
cab W w
cab Q q
cab WQ wq
cab Wq wq
" emacs bindings
cnoremap <c-a> <home>
cnoremap <c-e> <end>
" indent block
nnoremap <Leader>] >i{<CR>
nnoremap <Leader>[ <i{<CR>
" buffer nav
map <Right> :bnext<CR>
map <Left>  :bprev<CR>
" newline
map <Leader><CR> o<ESC>
" plugins
nmap <Leader>T= :Tabularize /=<CR>
vmap <Leader>T= :Tabularize /=<CR>
nmap <Leader>T<Space> :Tabularize /<Space><CR>
vmap <Leader>T<Space> :Tabularize /<Space><CR>
nmap <Leader>T: :Tabularize /:\zs<CR>
vmap <Leader>T: :Tabularize /:\zs<CR>
nmap sj :SplitjoinSplit<CR>
nmap sk :SplitjoinJoin<CR>
map <Leader>A :Ack! 
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
nnoremap <leader>w :silent !open <C-R>=escape("<C-R><C-F>", "#?&;\|%")<CR><CR>

" Das Auto
au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,Vagrantfile,Thorfile,Guardfile,config.ru} setf ruby
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} setf markdown
au BufRead,BufNewFile {SConstruct,SConscript,*.py} setf python.django
au BufNewFile,BufRead *.{nu,nujson},Nukefile setf nu
au BufRead,BufNewFile *.json setf javascript
au BufRead,BufNewFile *.conf setf config
au BufRead,BufNewFile *.ledger setf ledger | comp ledger
au BufRead,BufNewFile *gitconfig setf gitconfig
au BufRead,BufNewFile *nginx.conf setf nginx
au BufRead,BufNewFile quakelive.cfg setf quake
au BufRead,BufNewFile *.{css,sass,scss,less,styl} setlocal omnifunc=csscomplete#CompleteCSS
au BufRead,BufNewFile {*.go,Makefile} setlocal noexpandtab
au BufRead,BufNewFile *.{jar,war,ear,sar} setf zip
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
