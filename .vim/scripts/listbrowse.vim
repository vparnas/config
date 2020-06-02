autocmd BufAdd,BufRead * let b:ListMode = 0

function! ToggleListMode()
    if !b:ListMode
        call ListModeOn()
    else
        call ListModeOff()
    endif
endfunction

function! ListModeOn()
    echo "ListMode: On"
    let b:ListMode=1
    set foldmethod=indent
    setlocal foldignore=
    " setlocal foldclose=all " automatically close fold when moving out of it

    noremap <buffer> } zj
    noremap <buffer> { zk
    noremap <buffer> ] ]z
    noremap <buffer> [ [z
    noremap <buffer> <return> za
    noremap <buffer> <space> za
endfunction

function! ListModeOff()
    echo "ListMode: Off"
    let b:ListMode=0
    set foldmethod=manual
    setlocal foldignore=# " default value
    " setlocal foldclose= 

    noremap <buffer> } }
    noremap <buffer> { {
    noremap <buffer> ] ]
    noremap <buffer> [ [
    noremap <buffer> <return> <return>
    noremap <buffer> <space> <space>
endfunction

