" Typewriter mode: encourage typing, discourage editing or navigating text.
" Various normal-mode escapes disabled.
" save and quit insert-mode shortcuts enabled.

set insertmode
set swapfile
set updatetime=10000

" Disable the normal-mode escape (in insertmode)
imap <c-l> <nop>

" Disable the one-func insert-mode escape
imap <c-o> <nop>

" Disable the direction keys
imap <left> <nop>
imap <right> <nop>
imap <up> <nop>
imap <down> <nop>

" Disable the various forms of deletion
imap <c-u> <nop>
imap <c-w> <nop>
imap <BS> <nop>
imap <c-h> <nop>

imap <c-q> <cmd>:confirm q<CR>
imap <c-s> <cmd>:update<CR>
