function! SurroundWordWithCharacter(char)
   execute "normal gEwi" . a:char . "\<C-o>E\<right>" . a:char . "\<Esc>"
endfunction

function! SurroundVisualWithCharacter(char)
   execute "normal `>a" . a:char . "\<ESC>`<i" . a:char . "\<Esc>"
endfunction

function! AddTag(tagname)
    let tagname = input('Tag name: ', a:tagname, 'tag')
    let tagfile = expand('%:p')
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
endfunction

function! RemoveTrailingSpaces()
   %s/\s\+$//g
endfunction
command! RemoveTrailingSpaces call RemoveTrailingSpaces()

" ============ LISP ==============
autocmd FileType lisp map ;r :w !$LISP -q -norc<CR>

" ============ MARKDOWN ==============
autocmd Filetype markdown map <leader>h ggO---<cr>Title:<Space><++><cr>Date:<Space><++><Enter>Category:<Space><++><Enter>Status:<Space>Draft<Enter>...<Enter><Enter><esc>

" Generate a Table of Contents from section headers
" NOTE: Insure each section header terminates with <a name='anchor'></a>
autocmd Filetype markdown map <leader>T :call setreg('a', [])<CR>:g/^#/yank A<cr>:new +setlocal\ buftype=nofile<cr>:put!a<cr>:%s/#/\ /g<cr>:%s/^\s\+/\0-\ /g<cr>:%<<cr>:%s/\- \([^<]\+\)\s\+.*["']\(\w\+\)["'].*/- [\1](#\2)/g<cr> {O###<space>Contents<CR><ESC>

autocmd Filetype markdown map <leader>r Go###<Space>Sources<Space>referenced<space><a name="#ref"></a><CR><CR><esc>

" Execute before an inline link into to turn into a reference link
autocmd Filetype markdown map <leader>c /[<CR>mcyt)Gp<esc>0f(r:a<Space><c-o>A<esc>`ch/[<CR>f(ca([]<esc>mcvF[;y/#ref<CR>}PI1.<Space><c-[>o<esc>`ch
" Turn current word/selection into an inline link
autocmd Filetype markdown map <leader>w yiWi[<esc>Ea](<esc>pa)
autocmd Filetype markdown vmap <leader>w <ESC>`<i[<ESC>`>2la](<++>)<Esc>F(
" Make a hyphened list of all word-initiated lines, maintaining indents
autocmd Filetype markdown nmap ;l :%s/^\(\s*\)\(\w\)/\1- \2/gc<CR>
autocmd Filetype markdown vmap ;l :s/^\(\s*\)\(\w\)/\1- \2/gc<CR>
autocmd Filetype markdown inoremap ;i ![image](<++>)<++><Esc>F[a
autocmd Filetype markdown inoremap ;a [](<++>)<++><Esc>F[a
autocmd Filetype markdown inoremap ,1 #<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,2 ##<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,3 ###<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,4 ####<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,c ```<cr>```<cr><cr><esc>2kO
" convert CSV data to markup table
autocmd Filetype markdown vmap <buffer> ;t :!sed '1p; 1s/[^,]\+/:---:/g; s/,/ \| /g; s/^.*$/\| \0 \|/g'<cr>
" Open buffer or selection in an html preview. Requires 'lowdown' markdown converter.
autocmd Filetype markdown map <buffer> ,M :w !lowdown -D html-skiphtml -D html-head-ids -e math \| w3m -T text/html<CR>

" Insert a named anchor, both Markdown and HTML
autocmd FileType markdown,html inoremap ,A <a<Space>name=''></a><Esc>F'i

"""HTML
autocmd FileType html inoremap ,b <b></b><Space><++><Esc>FbT>i
autocmd FileType html inoremap ,it <em></em><Space><++><Esc>FeT>i
autocmd FileType html inoremap ,1 <h1></h1><Enter><Enter><++><Esc>2kf<i
autocmd FileType html inoremap ,2 <h2></h2><Enter><Enter><++><Esc>2kf<i
autocmd FileType html inoremap ,3 <h3></h3><Enter><Enter><++><Esc>2kf<i
autocmd FileType html inoremap ,p <p></p><Enter><Enter><++><Esc>02kf>a
autocmd FileType html inoremap ,a <a<Space>href=""><++></a><Space><++><Esc>14hi
autocmd FileType html inoremap ,e <a<Space>target="_blank"<Space>href=""><++></a><Space><++><Esc>14hi
autocmd FileType html inoremap ,ul <ul><Enter><li></li><Enter></ul><Enter><Enter><++><Esc>03kf<i
autocmd FileType html inoremap ,li <Esc>o<li></li><Esc>F>a
autocmd FileType html inoremap ,ol <ol><Enter><li></li><Enter></ol><Enter><Enter><++><Esc>03kf<i
autocmd FileType html inoremap ,im <img src="" alt="<++>"><++><esc>Fcf"a
autocmd FileType html inoremap ,td <td></td><++><Esc>Fdcit
autocmd FileType html inoremap ,tr <tr></tr><Enter><++><Esc>kf<i
autocmd FileType html inoremap ,th <th></th><++><Esc>Fhcit
autocmd FileType html inoremap ,tab <table><Enter></table><Esc>O
autocmd FileType html inoremap ,gr <font color="green"></font><Esc>F>a
autocmd FileType html inoremap ,rd <font color="red"></font><Esc>F>a
autocmd FileType html inoremap ,yl <font color="yellow"></font><Esc>F>a
autocmd FileType html inoremap ,dt <dt></dt><Enter><dd><++></dd><Enter><++><esc>2kcit
autocmd FileType html inoremap ,dl <dl><Enter><Enter></dl><enter><enter><++><esc>3kcc
autocmd FileType html inoremap &<space> &amp;<space>
autocmd FileType html inoremap á &aacute;
autocmd FileType html inoremap é &eacute;
autocmd FileType html inoremap í &iacute;
autocmd FileType html inoremap ó &oacute;
autocmd FileType html inoremap ú &uacute;
autocmd FileType html inoremap ã &atilde;
autocmd FileType html inoremap õ &otilde;
autocmd FileType html inoremap ũ &utilde;
autocmd FileType html inoremap ñ &ntilde;
autocmd FileType html inoremap à &agrave;
autocmd FileType html inoremap è &egrave;
autocmd FileType html inoremap ì &igrave;
autocmd FileType html inoremap ò &ograve;
autocmd FileType html inoremap ù &ugrave;

" ============ LATEX ==============
" Word count:
autocmd FileType tex map <F3> :w !detex \| wc -w<CR>
autocmd FileType tex inoremap <F3> <Esc>:w !detex \| wc -w<CR>
" Code snippets
autocmd FileType tex inoremap ;fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
autocmd FileType tex inoremap ;em \emph{}<++><Esc>T{i
autocmd FileType tex inoremap ;bf \textbf{}<++><Esc>T{i
" Surround visual selection with parenthesis
autocmd FileType tex vnoremap ; <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
autocmd FileType tex inoremap ;it \textit{}<++><Esc>T{i
autocmd FileType tex inoremap ;ct \textcite{}<++><Esc>T{i
autocmd FileType tex inoremap ;cp \parencite{}<++><Esc>T{i
autocmd FileType tex inoremap ;ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap ;ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap ;li <Enter>\item<Space>
autocmd FileType tex inoremap ;ref \ref{}<Space><++><Esc>T{i
" Render a table
autocmd FileType tex inoremap ;tab <Enter>\begin{table}[h!]<Enter>\centering<Enter>\begin{tabular}{c<c-o>3a\|c<Esc>a}<Enter>\hline<Enter><++><c-o>3a<Space>&<Space><++><Esc>a<Space>\\<Enter>\hline<Enter>\end{tabular}<Enter>\caption{<++>}<Enter>\label{tbl:<++>}<Enter>\end{table}<Enter><Esc>{
autocmd FileType tex inoremap ;a \href{}{<++>}<Space><++><Esc>2T{i
autocmd FileType tex inoremap ;sc \textsc{}<Space><++><Esc>T{i
autocmd FileType tex inoremap ;chap \chapter{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ;sec \section{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ;ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ;sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
" Place a star behind opening curly brace
autocmd FileType tex inoremap ;st <Esc>F{i*<Esc>f}i
autocmd FileType tex inoremap ;up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
autocmd FileType tex nnoremap ;up /usepackage<Enter>o\usepackage{}<Esc>i
autocmd FileType tex inoremap ;nu $\varnothing$
autocmd FileType tex inoremap ;col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
autocmd FileType tex inoremap ;rn (\ref{})<++><Esc>F}i

" ============ BIB ==============
autocmd FileType bib inoremap ;a @article{<Enter><tab>author<Space>=<Space>"<++>",<Enter><tab>year<Space>=<Space>"<++>",<Enter><tab>title<Space>=<Space>"<++>",<Enter><tab>journal<Space>=<Space>"<++>",<Enter><tab>volume<Space>=<Space>"<++>",<Enter><tab>pages<Space>=<Space>"<++>",<Enter><tab>}<Enter><++><Esc>8kA,<Esc>i
autocmd FileType bib inoremap ;b @book{<Enter><tab>author<Space>=<Space>"<++>",<Enter><tab>year<Space>=<Space>"<++>",<Enter><tab>title<Space>=<Space>"<++>",<Enter><tab>publisher<Space>=<Space>"<++>",<Enter><tab>}<Enter><++><Esc>6kA,<Esc>i
autocmd FileType bib inoremap ;c @incollection{<Enter><tab>author<Space>=<Space>"<++>",<Enter><tab>title<Space>=<Space>"<++>",<Enter><tab>booktitle<Space>=<Space>"<++>",<Enter><tab>editor<Space>=<Space>"<++>",<Enter><tab>year<Space>=<Space>"<++>",<Enter><tab>publisher<Space>=<Space>"<++>",<Enter><tab>}<Enter><++><Esc>8kA,<Esc>i

" ========== More Functions ==========
" \vs: display same file in two continuous virtical panes
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
