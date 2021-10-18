" Vim global plugin for open terminal inside vim
" Last Cahgne 2021 Oct 15
" Maintainer: Zaenul Hilmi <zaenulhilmi@gmail.com>
" License: This file is placed in the public domain.


let s:save_cpo = &cpo
set cpo&vim


if exists("g:loaded_terminside")
    finish
endif
let g:loaded_terminside = 1

tnoremap <Esc> <C-\><C-n>

map <M-0> <Plug>TerminsideOpen;
tnoremap <M-0> <Plug>TerminsideClose;

noremap <unique> <M-c> <Plug>TerminsideOpen;

if !hasmapto('<Plug>TerminsideOpen;')
    map <M-0> <Plug>TerminsideOpen;
endif

if !hasmapto('<Plug>TerminsideClose;')
    tnoremap <M-0> <c-\><C-n>:hide<cr>
endif

noremap <unique> <script> <Plug>TerminsideOpen;  <SID>Open
noremap <SID>Open  :call <SID>Open("x")<CR>


noremap <unique> <script> <Plug>TerminsideClose;  <SID>Close
noremap <SID>Close  :call <SID>Close()<CR>

function! s:Close()
    exec "<c-\><C-n>:hide<cr>" 
endfunction

function! s:Open(name)
    let bufnum=bufnr(expand(a:name))
    if bufnum == -1
        botright split term://bash
        execute 'file' a:name
        startinsert
        return
    endif

    let winnum=bufwinnr(bufnum)
    if winnum != 1
        let current_window = winnr()
        if current_window == winnum 
            hide
        else 
            botright split
            exe 'buffer' a:name
            startinsert
        endif
    else 
        startinsert
    endif
endfunction

function! s:isBufferExist(name)
    let bufnum=bufnr(expand(a:name))
    if bufnum == -1
        return 0
    endif 

    return 1
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
