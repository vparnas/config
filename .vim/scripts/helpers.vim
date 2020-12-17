" Set the next unused lowercase [a-z] mark. 
" If 'z' occupied, continue round-robin to 'a'
function! NewMark()
    if (version < 802)
        return
    endif
    if (!exists('b:last_mark'))
        let list = getmarklist(bufname())
        call filter(list, {idx, val -> val['mark'] =~ '[a-z]'})
        if (len(list) == 0)
            let b:last_mark = 'z'
        else
            let b:last_mark = strpart(list[-1].mark, 1)
        endif
    endif
    if (b:last_mark == 'z')
        let b:last_mark = 'a'
    else
        let b:last_mark = nr2char(char2nr(b:last_mark) + 1)
    endif
    execute "mark" b:last_mark
    echo "Mark set:" b:last_mark
endfunction
command! NewMark call NewMark()

" Surround the current word or selected text with 'char':
"   symmetric parentheses/brackets, if one of '[](){}<>'
"   '**' (markdown bold) if 'b'
"   '"' (double quotes) if q
"   Otherwise, the character passed verbatim
function! SurroundText(char, mode)
    let [left, right] = [a:char,  a:char]
    if (a:char =~ '[\[\]]')
        let [left, right] = ['[',  ']']
    elseif (a:char =~ '[()]')
        let [left, right] = ['(',  ')']
    elseif (a:char =~ '[{}]')
        let [left, right] = ['{',  '}']
    elseif (a:char =~ '[<>]')
        let [left, right] = ['<',  '>']
    elseif (a:char == 'b')
        let [left, right] = ['**', '**']
    elseif (a:char == 'q')
        let [left, right] = ['"',  '"']
    endif
    if (a:mode =~ 'v')
        execute "normal \<ESC>`>a" . right . "\<ESC>`<i" . left . "\<Esc>"
    else
        execute "normal gEwi" . left . "\<C-o>e\<right>" . right . "\<Esc>"
    endif
endfunction

function! SwitchFields(delim)
    call SwitchFieldsUntilTerm(a:delim, a:delim)
endfunction

" Switch everything from current word to the character 'delim'
" with everything that follows after until the character 'term' (or EOL)
function! SwitchFieldsUntilTerm(delim, term)
    exec 'silent! :s/\v(\k*%#.{-})(\s*' . a:delim . '\s*)([^' . a:term . ']*)/\3\2\1/'
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
