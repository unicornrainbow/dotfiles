if has("gui_running")
    set go-=T
    set go-=l
    set go-=L
    set go-=r
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
execute "HeadlightsTurnOn"
