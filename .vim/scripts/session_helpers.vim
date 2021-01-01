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

" au BufWinLeave * mkview
" au BufWinEnter * silent loadview
" au VimEnter * nested :call LoadSession()
" au VimLeave * :call UpdateSession()
" Map \u, \m, \l to appropriate actions on session
map <leader>M :call MakeSession()<CR>
map <leader>L :call LoadSession()<CR>
