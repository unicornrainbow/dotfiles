" This came from Greg V's dotfiles:
"      https://github.com/myfreeweb/dotfiles
" Feel free to steal it, but attribution is nice
"
" Thanks: see vimrc

" File types
au BufRead,BufNewFile {Gem,Rake,Cap,Vagrant,Thor,Guard}file,config.ru setf ruby
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,ronn} setf markdown
au BufRead,BufNewFile {SConstruct,SConscript} setf python
au BufRead,BufNewFile *.conf setf config
au BufRead,BufNewFile *.ledger setf ledger | comp ledger
au BufRead,BufNewFile *gitconfig setf gitconfig
au BufRead,BufNewFile nginx.conf setf nginx
au BufRead,BufNewFile *.gradle setf groovy
au BufRead,BufNewFile *.sbt setf scala
au BufRead,BufNewFile *.scaml setf haml
au BufRead,BufNewFile *.go setf go
au BufRead,BufNewFile quakelive.cfg setf quake
au BufRead,BufNewFile *.{css,sass,scss,less,styl} setlocal iskeyword+=-
au BufRead,BufNewFile {*.go,Makefile,.git*,*gitconfig} setlocal noexpandtab
au BufRead,BufNewFile *.{jar,war,ear,sar} setf zip
au BufRead,BufNewFile *.fish setf tcsh

" Completion
au BufRead,BufNewFile *.{css,sass,scss,less,styl} setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" Automatic lint/format/etc
au BufWritePost {g,.g,,.}vimrc source $MYVIMRC | exe ":PowerlineReloadColorscheme"
au BufWritePost *.py call Flake8()
au BufWritePost *.coffee :CoffeeLint | cwindow
au BufWritePost *.hs :GhcModCheckAndLintAsync | cwindow
au BufWritePre *.go :Fmt

" Folds
au FileType {vim,javascript} setlocal foldmethod=marker
au FileType ruby setlocal foldmethod=syntax
au FileType coffee setlocal foldmethod=indent
au BufRead,BufNewFile {,.}zshrc,*.fish setlocal foldmethod=marker

" Line numbers
au InsertEnter * set number
au InsertLeave * set relativenumber

" Misc
au BufReadPost fugitive://* setlocal bufhidden=delete
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
au VimResized * exe "normal! \<c-w>="
au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
