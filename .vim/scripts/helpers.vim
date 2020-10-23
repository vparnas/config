function! SurroundWordWithCharacter(char)
    let left = a:char
    let right = a:char
    if (a:char == '[' || a:char == ']')
        let left = '['
        let right = ']'
    elseif (a:char == '(' || a:char == ')')
        let left = '('
        let right = ')'
    elseif (a:char == '{' || a:char == '}')
        let left = '{'
        let right = '}'
    elseif (a:char == '<' || a:char == '>')
        let left = '<'
        let right = '>'
    endif
    execute "normal gEwi" . left . "\<C-o>E\<right>" . right . "\<Esc>"
endfunction

function! SurroundVisualWithCharacter(char)
    let left = a:char
    let right = a:char
    if (a:char == '[' || a:char == ']')
        let left = '['
        let right = ']'
    elseif (a:char == '(' || a:char == ')')
        let left = '('
        let right = ')'
    elseif (a:char == '{' || a:char == '}')
        let left = '{'
        let right = '}'
    elseif (a:char == '<' || a:char == '>')
        let left = '<'
        let right = '>'
    endif
    execute "normal `>a" . right . "\<ESC>`<i" . left . "\<Esc>"
endfunction

function! AddTag(tagname)
    let tagname = input('Tag name: ', a:tagname, 'tag')
    let tagfile = expand('%:p:~') " filename relative to home directory
    let tagaddress = input('Address: ', '/\<' . a:tagname . '\>/')
    if (tagname == ''  || tagaddress == '')
        return
    endif
    let cmd = '!echo -e "' . tagname . '\t' . tagfile . '\t' . tagaddress . '" >> ' . $TAGS_GLOBAL
    execute cmd
endfunction

function! ToggleTabLine()
    if &showtabline
        set showtabline=0
    else
        set showtabline=1
    endif
endfunction

" Renames the file and exchanges buffer accordingly
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':silent! !mv ' . old_name new_name
        exec ':e ' . new_name
        exec ':bd ' . old_name
        redraw!
    endif
    let @# = @%
endfunction

function! RemoveTrailingSpaces()
   %s/\s\+$//g
endfunction
command! RemoveTrailingSpaces call RemoveTrailingSpaces()

" <leader>vs: display same file in two continuous virtical panes
:noremap <silent> <Leader>vs :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>
" The mapping (activate via \vs) performs these operations: 
" :<C-u>              " clear command line (if in visual mode)
" let @z=&so          " save scrolloff in register z
" :set so=0 noscb     " set scrolloff to 0 and clear scrollbind
" :bo vs              " split window vertically, new window on right
" Ljzt                " jump to bottom of window + 1, scroll to top
" :setl scb           " setlocal scrollbind in right window
" <C-w>p              " jump to previous window
" :setl scb           " setlocal scrollbind in left window
" :let &so=@z         " restore scrolloff

" Generate a word frequency table in a new buffer
function! WordFrequency() range
    let all = split(join(getline(a:firstline, a:lastline)), '\A\+')
    let frequencies = {}
    for word in all
        let frequencies[word] = get(frequencies, word, 0) + 1
    endfor
    new
    setlocal buftype=nofile bufhidden=hide noswapfile tabstop=20
    for [key,value] in items(frequencies)
        call append('$', key."\t".value)
    endfor
    sort i
endfunction
command! -range=% WordFrequency <line1>,<line2>call WordFrequency()
