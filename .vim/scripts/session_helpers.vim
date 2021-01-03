" ===========================
" Session Saving/Loading 
" ===========================
set sessionoptions=buffers,curdir,folds,help,tabpages,winsize,terminal

" Creates a session
function! MakeSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:sessionfile = b:sessiondir . '/session.vim'
  " Don't save arguments to prevent them from reloading 
  " when their respective buffers are deleted
  exe "%argdelete"
  exe "mksession! " . b:sessionfile
endfunction

" Loads a session if it exists and vim started with no arguments
function! LoadSession()
  if argc() == 0
    let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
    let b:sessionfile = b:sessiondir . "/session.vim"
    if (filereadable(b:sessionfile))
      exe 'source ' b:sessionfile
    else
      echo "No session loaded."
    endif
  endif
endfunction

" au VimEnter * nested :call LoadSession()
" au VimLeave * :call UpdateSession()
map <leader>M :call MakeSession()<CR>
map <leader>L :call LoadSession()<CR>
