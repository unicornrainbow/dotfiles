if has("gui_running")
    set go-=T
    set go-=l
    set go-=L
    set go-=r
    set go-=R
endif
if has("gui_macvim")
    set guifont=Monaco:h12
    macmenu &File.New\ Tab key=<nop>
    map <D-t> :CommandT<CR>
    map <D-Bslash> <plug>NERDCommenterToggle<CR>
endif
execute "HeadlightsTurnOn"
