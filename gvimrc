if has("gui_running")
    set go-=T
    set go-=l
    set go-=L
    set go-=R
endif
if has("gui_macvim")
    macmenu &File.New\ Tab key=<nop>
    set guifont=Monaco:h12
    map <D-t> :CommandT<CR>
    map <D-Bslash> <plug>NERDCommenterToggle<CR>
else
    set guifont=Monaco "linux doesn't like size here
endif
" au BufAdd,BufNewFile * nested tab sball
tab sball
set switchbuf=usetab,newtab
execute "HeadlightsTurnOn"
