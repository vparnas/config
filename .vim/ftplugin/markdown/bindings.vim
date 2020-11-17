map <buffer> <leader>h ggO---<cr>Title:<Space><++><cr>Date:<Space><++><Enter>Category:<Space><++><Enter>Status:<Space>Published<Enter>...<Enter><Enter><esc>

" Generate a Table of Contents from section headers
" NOTE: Insure each section header terminates with <a name='anchor'></a>
" TODO: convert to a function within helpers.vim
map <buffer> <leader>T :call setreg('a', [])<CR>:g/^#/yank A<cr>:new +setlocal\ buftype=nofile<cr>:put!a<cr>:%s/#/\ /g<cr>:%s/^\s\+/\0-\ /g<cr>:%<<cr>:%s/\- \([^<]\+\)\s\+.*["']\(\w\+\)["'].*/- [\1](#\2)/g<cr> {O###<space>Contents<CR><ESC>

" Turn current word/selection into an inline link
map <buffer> <leader>w yiWi[<esc>Ea](<esc>pa)
vmap <buffer> <leader>w <ESC>`<i[<ESC>`>2la](<++>)<Esc>F(
" Make a hyphened list of all word-initiated lines, maintaining indents
nmap <buffer> ;l :%s/^\(\s*\)\(\w\)/\1- \2/gc<CR>
vmap <buffer> ;l :s/^\(\s*\)\(\w\)/\1- \2/gc<CR>
inoremap <buffer> ,i ![](<++>)<++><Esc>F[a
inoremap <buffer> ,a [](<++>)<++><Esc>F[a
inoremap <buffer> ,1 #<Space>
inoremap <buffer> ,2 ##<Space>
inoremap <buffer> ,3 ###<Space>
inoremap <buffer> ,4 ####<Space>
" Code block
inoremap <buffer> ,c ```<cr>```<cr><cr><esc>2kO
" convert CSV data to markup table
vmap <buffer> <buffer> ;t :!sed '1p; 1s/[^,]\+/:---:/g; s/,/ \| /g; s/^.*$/\| \0 \|/g'<cr>
" Open buffer or selection in an html preview. Requires 'lowdown' markdown converter.
map <buffer> <buffer> ,M :w !lowdown -D html-skiphtml -D html-head-ids -e math \| w3m -T text/html<CR>

" Insert a named anchor
inoremap <buffer> ,A <a<Space>name=''></a><Esc>F'i
