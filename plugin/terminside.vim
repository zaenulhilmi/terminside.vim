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
tmap <unique> <M-c> <esc>:call <SID>createNew() <cr>
tmap <unique> <M-n> <esc>:call <SID>OpenNext() \| startinsert<cr>
tmap <unique> <M-p> <esc>:call <SID>OpenPrev() \| startinsert<cr>

if !hasmapto('<Plug>TerminsideOpen;')
    map <M-0> <Plug>TerminsideOpen;
endif

if !hasmapto('<Plug>TerminsideClose;')
    tnoremap <M-0> <c-\><C-n>:hide<cr>
endif

noremap <unique> <script> <Plug>TerminsideOpen;  <SID>Open
noremap <SID>Open  :call <SID>Open()<CR>


noremap <unique> <script> <Plug>TerminsideClose;  <SID>Close
noremap <SID>Close  :call <SID>Close()<CR>



function! s:OpenNext() 
    echom g:terminals
    let length = len(g:terminals)
    let i = 0
    let termPos = 0
    for x in g:terminals
        if x == g:terminal
            let termPos = i
        endif
        let i += 1
    endfor

    let termPos = (termPos + 1) % length
    let g:terminal = g:terminals[termPos]
    exe 'buffer' g:terminal
    startinsert
endfunction


function! s:OpenPrev() 
    echom g:terminals
    let length = len(g:terminals)
    let i = 0
    let termPos = 0
    for x in g:terminals
        if x == g:terminal
            let termPos = i
        endif
        let i += 1
    endfor

    let termPos = (termPos - 1) % length
    let g:terminal = g:terminals[termPos]
    exe 'buffer' g:terminal
    startinsert
endfunction

function! s:createNew()
    hide
    botright split 
    terminal
    let g:terminal = bufname("%")
    call add(g:terminals, g:terminal)
    startinsert
endfunction



function! s:Close()
    exec "<c-\><C-n>:hide<cr>" 
endfunction

let g:terminal = ""

let g:terminals = []

function! s:Open()

    let terms = len(g:terminals)

    if terms == 0
        botright split 
        terminal
        let g:terminal = bufname("%")
        call add(g:terminals, g:terminal)
        startinsert
        return
    endif

    let bufnum=bufnr(expand(g:terminal))
    echom bufnum
    if bufnum == -1
        botright split 
        terminal
        let g:terminal = bufname("%")
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
            exe 'buffer' g:terminal
            startinsert
        endif
    else 
        startinsert
    endif
endfunction

function! s:isBufferExist()
    let bufnum=bufnr(expand(g:terminal))
    if bufnum == -1
        return 0
    endif 

    return 1
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
