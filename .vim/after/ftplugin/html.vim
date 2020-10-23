" NOTE: the html ftplugin is also loaded by the VIM *global* markdown plugin
" Hence html filetype explicitly specified here

au filetype html inoremap <buffer> ,b <b></b><Space><++><Esc>FbT>i
au filetype html inoremap <buffer> ,it <em></em><Space><++><Esc>FeT>i
au filetype html inoremap <buffer> ,1 <h1></h1><Enter><Enter><++><Esc>2kf<i
au filetype html inoremap <buffer> ,2 <h2></h2><Enter><Enter><++><Esc>2kf<i
au filetype html inoremap <buffer> ,3 <h3></h3><Enter><Enter><++><Esc>2kf<i
au filetype html inoremap <buffer> ,p <p></p><Enter><Enter><++><Esc>02kf>a
au filetype html inoremap <buffer> ,a <a<Space>href=""><++></a><Space><++><Esc>14hi
au filetype html inoremap <buffer> ,e <a<Space>target="_blank"<Space>href=""><++></a><Space><++><Esc>14hi
au filetype html inoremap <buffer> ,ul <ul><Enter><li></li><Enter></ul><Enter><Enter><++><Esc>03kf<i
au filetype html inoremap <buffer> ,li <Esc>o<li></li><Esc>F>a
au filetype html inoremap <buffer> ,ol <ol><Enter><li></li><Enter></ol><Enter><Enter><++><Esc>03kf<i
au filetype html inoremap <buffer> ,im <img src="" alt="<++>"><++><esc>Fcf"a
au filetype html inoremap <buffer> ,td <td></td><++><Esc>Fdcit
au filetype html inoremap <buffer> ,tr <tr></tr><Enter><++><Esc>kf<i
au filetype html inoremap <buffer> ,th <th></th><++><Esc>Fhcit
au filetype html inoremap <buffer> ,tab <table><Enter></table><Esc>O
au filetype html inoremap <buffer> ,gr <font color="green"></font><Esc>F>a
au filetype html inoremap <buffer> ,rd <font color="red"></font><Esc>F>a
au filetype html inoremap <buffer> ,yl <font color="yellow"></font><Esc>F>a
au filetype html inoremap <buffer> ,dt <dt></dt><Enter><dd><++></dd><Enter><++><esc>2kcit
au filetype html inoremap <buffer> ,dl <dl><Enter><Enter></dl><enter><enter><++><esc>3kcc
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

" Insert a named anchor
au filetype html inoremap <buffer> ,A <a<Space>name=''></a><Esc>F'i
