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

" Updates a session, BUT ONLY IF IT ALREADY EXISTS
function! UpdateSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe "mksession! " . b:sessionfile
    echo "updating session"
  endif
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
  else
    let b:sessionfile = ""
    let b:sessiondir = ""
  endif
endfunction

" au BufWinLeave * mkview
" au BufWinEnter * silent loadview
" au VimEnter * nested :call LoadSession()
" au VimLeave * :call UpdateSession()
" Map \u, \m, \l to appropriate actions on session
map <leader>U :call UpdateSession()<CR>
map <leader>M :call MakeSession()<CR>
map <leader>L :call LoadSession()<CR>
