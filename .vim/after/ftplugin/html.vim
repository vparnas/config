inoremap <buffer> ,b <b></b><Space><++><esc>2T>i
vnoremap <buffer> ,b <cmd>call SurroundText2('<b>', '</b>')<CR>
inoremap <buffer> ,it <em></em><Space><++><esc>2T>i
vnoremap <buffer> ,it <cmd>call SurroundText2('<em>', '</em>')<CR>
inoremap <buffer> ,1 <h1></h1><Enter><++><esc>kcit
vnoremap <buffer> ,1 <cmd>call SurroundText2('<h1>', '</h1>')<CR>
inoremap <buffer> ,2 <h2></h2><Enter><++><esc>kcit
vnoremap <buffer> ,2 <cmd>call SurroundText2('<h2>', '</h2>')<CR>
inoremap <buffer> ,3 <h3></h3><Enter><++><esc>kcit
vnoremap <buffer> ,3 <cmd>call SurroundText2('<h3>', '</h3>')<CR>
inoremap <buffer> ,p <p></p><Enter><++><Esc>kcit
vnoremap <buffer> ,p <cmd>call SurroundText2('<p>', '</p>')<CR>
inoremap <buffer> ,a <a<Space>href=""><++></a><Space><++><c-o>F"
vnoremap <buffer> ,a <cmd>call SurroundText2('<a<space>href="">', '</a>')<CR>hi
inoremap <buffer> ,e <a<Space>target="_blank"<Space>href=""><++></a><Space><++><c-o>F"
inoremap <buffer> ,ul <ul><Enter><li></li><Enter></ul><Enter><++><Esc>2kcit
vnoremap <buffer> ,ul <cmd>call SurroundText2('<ul><li>', '</li></ul>')<CR>
inoremap <buffer> ,li <Esc>o<li></li><esc>T>i
vnoremap <buffer> ,li <cmd>call SurroundText2('<li>', '</li>')<CR>
inoremap <buffer> ,ol <ol><Enter><li></li><Enter></ol><Enter><++><Esc>2kcit
vnoremap <buffer> ,ol <cmd>call SurroundText2('<ol><li>', '</li></ol>')<CR>
inoremap <buffer> ,im <img src="" alt="<++>"><++><c-o>3F"
inoremap <buffer> ,td <td></td><++><esc>2T>i
vnoremap <buffer> ,td <cmd>call SurroundText2('<td>', '</td>')<CR>
inoremap <buffer> ,tr <tr></tr><Enter><++><Esc>kcit
vnoremap <buffer> ,tr <cmd>call SurroundText2('<tr>', '</tr>')<CR>
inoremap <buffer> ,th <th></th><++><esc>2T>i
inoremap <buffer> ,tab <table><Enter></table><Esc>O
inoremap <buffer> ,dt <dt></dt><Enter><dd><++></dd><Enter><++><esc>2kcit
inoremap <buffer> ,dl <dl><Enter><Enter></dl><enter><enter><++><esc>3kcc
inoremap <buffer> ,v <pre><Enter></pre><Enter><++><Esc>2kA
vnoremap <buffer> ,v <cmd>call SurroundText2('<pre>', '</pre>')<CR>
inoremap <buffer> ,c <code></code><Space><++><esc>2T>i
vnoremap <buffer> ,c <cmd>call SurroundText2('<code>', '</code>')<CR>

" Insert a named anchor
inoremap <buffer> ,A <a<Space>name=''></a><Esc>F'i

" NOTE: the html ftplugin is also loaded by the VIM *global* markdown plugin
" Hence make these mappings exclusive for html
au filetype html inoremap <buffer> &<space> &amp;<space>
au filetype html inoremap <buffer> á &aacute;
au filetype html inoremap <buffer> é &eacute;
au filetype html inoremap <buffer> í &iacute;
au filetype html inoremap <buffer> ó &oacute;
au filetype html inoremap <buffer> ú &uacute;
au filetype html inoremap <buffer> ã &atilde;
au filetype html inoremap <buffer> õ &otilde;
au filetype html inoremap <buffer> ũ &utilde;
au filetype html inoremap <buffer> ñ &ntilde;
au filetype html inoremap <buffer> à &agrave;
au filetype html inoremap <buffer> è &egrave;
au filetype html inoremap <buffer> ì &igrave;
au filetype html inoremap <buffer> ò &ograve;
au filetype html inoremap <buffer> ù &ugrave;

" Render the html in w3m, the terminal web browser
au filetype html map <buffer> ,M :w !w3m -T text/html<CR>
