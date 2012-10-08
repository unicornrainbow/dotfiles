" This came from Greg V's dotfiles:
"      https://github.com/myfreeweb/dotfiles
" Feel free to steal it, but attribution is nice

let mapleader = ","
let maplocalleader = "\\"

" j and k inverted for colemak
noremap k gj
noremap j gk

noremap ' i
noremap U <C-r>
nnoremap ; :
nnoremap <Space> za
vnoremap <Space> za
map <Leader><CR> o<ESC>
nnoremap Y y$
nnoremap <CR> :nohlsearch<CR>
imap <C-l> <Space>=><Space>
map <Leader>d :bd<CR>
nnoremap <leader>u :syntax sync fromstart<cr>:redraw!<cr> " Unfuck my screen

" windows
map <C-h> <C-w>h
map <C-k> <C-w>j
map <C-j> <C-w>k
map <C-l> <C-w>l

" case-insensitive
cab E e
cab W w
cab Q q
cab WQ wq
cab Wq wq

" emacs bindings
inoremap <C-a> <home>
inoremap <C-e> <end>

" buffer nav
map <Right> :bnext<CR>
map <Left>  :bprev<CR>

" plugins and stuff
nmap <Leader>T= :Tabularize /=<CR>
vmap <Leader>T= :Tabularize /=<CR>
nmap <Leader>T<Space> :Tabularize /<Space><CR>
vmap <Leader>T<Space> :Tabularize /<Space><CR>
nmap <Leader>T: :Tabularize /:\zs<CR>
vmap <Leader>T: :Tabularize /:\zs<CR>
nmap sk :SplitjoinSplit<CR>
nmap sj :SplitjoinJoin<CR>
map <Leader>w :w<CR>
map <Leader>W :SudoWrite<CR>
map <Leader>a :Ack! 
map <Leader>m :Rename 
map <Leader>rb :RunRubyFocusedTest<CR>
map <Leader>c :VimuxPromptCommand<CR>
map <Leader>vq :VimuxCloseRunner<CR>
map <Leader>vx :VimuxInterruptRunner<CR>
nnoremap <Leader>b :silent !open <C-R>=escape("<C-R><C-F>", "#?&;\|%")<CR><CR> " open URLs

" Motion for numbers.  Great for CSS.  Lets you do things like this:
" margin-top: 200px; -> daN -> margin-top: px;
onoremap N :<c-u>call <SID>NumberTextObject(0)<cr>
xnoremap N :<c-u>call <SID>NumberTextObject(0)<cr>
onoremap aN :<c-u>call <SID>NumberTextObject(1)<cr>
xnoremap aN :<c-u>call <SID>NumberTextObject(1)<cr>
onoremap iN :<c-u>call <SID>NumberTextObject(1)<cr>
xnoremap iN :<c-u>call <SID>NumberTextObject(1)<cr>
function! s:NumberTextObject(whole)
    normal! v
    while getline('.')[col('.')] =~# '\v[0-9]'
        normal! l
    endwhile
    if a:whole
        normal! o
        while col('.') > 1 && getline('.')[col('.') - 2] =~# '\v[0-9]'
            normal! h
        endwhile
    endif
endfunction
