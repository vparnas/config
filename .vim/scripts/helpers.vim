" Set the next unused lowercase [a-z] mark.
" If 'z' occupied, continue round-robin to 'a'
function! NewMark()
    if (version < 802) | echo "unsupported version" | return | endif
    if (!exists('b:last_mark'))
        let list = getmarklist(bufname())
        call filter(list, {idx, val -> val['mark'] =~ '[a-z]'})
        let b:last_mark = (len(list) == 0) ? 'z' : strpart(list[-1].mark, 1)
    endif
    let b:last_mark = (b:last_mark == 'z') ? 'a' :
                \ nr2char(char2nr(b:last_mark) + 1)
    execute "mark" b:last_mark
    echo "Mark set:" b:last_mark
endfunction
command! NewMark call NewMark()

" Surround the current word or selected text with 'char':
"   symmetric parentheses/brackets, if one of '[](){}<>'
"   '**' (markdown bold) if 'b'
"   '"' (double quotes) if q
"   Otherwise, the character passed verbatim
function! SurroundText(char)
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
    call SurroundText2(left, right)
endfunction

function! SurroundText2(left, right)
    let old_paste = &paste
    set paste " set paste mode to avoid incidental insert-mode abbreviations
    if (mode() =~ 'v')
        execute "normal \<ESC>`>a" . a:right . "\<C-c>`<i" . a:left . "\<C-c>"
    else
        execute "normal gEwi" . a:left . "\<C-c>ea" . a:right . "\<Right>\<C-c>"
    endif
    if !old_paste | set nopaste | endif
endfunction

function! SwitchFields(delim)
    call SwitchFieldsUntilTerm(a:delim, a:delim)
endfunction

" Switch (depending on mode)
"   normal: everything from current word to the character 'delim'
"   visual: selection
" with everything after 'delim' until the character 'term' (or EOL)
function! SwitchFieldsUntilTerm (delim, term)
    let regex_second_part = a:delim . '\s*)([^\' . a:term . ']*)/\3\2\1/'
    if (mode() =~ 'v')
        exec ':silent! s/\v(%V.*%V.)(.{-}\s*\' . regex_second_part
    else
        exec ':silent! s/\v(\k*%#.{-})(\s*\' . regex_second_part
    endif
endfunction

function! AddTag(tagname)
    let tagname = input('Tag name: ', a:tagname, 'tag')
    let tagfile = expand('%:p:~') " filename relative to home directory
    let tagaddress = input('Address: ', '/\<' . a:tagname . '\>/')
    if (tagname == ''  || tagaddress == '')
        return
    endif
    let cmd = '!echo -e "' . tagname . '\t' . tagfile . '\t' . tagaddress . '" >> ' . $TAGS_GLOBAL
    execute 'silent ' . cmd
    redraw!
    echo 'Tag added'
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
    let new_name = input('New file name: ', old_name, 'file')
    let old_alt_file = @#
    if new_name == '' || new_name == old_name | return | endif
    exec ':silent! !mv ' . old_name new_name
    exec ':e ' . new_name
    exec ':bd ' . old_name
    redraw!
    if old_alt_file != ''
        let @# = old_alt_file
    else
        let @# = @%
    endif
endfunction

command! -range=% RemoveTrailingSpaces <line1>,<line2>s/\s\+$//

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
