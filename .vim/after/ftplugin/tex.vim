" Word count:
map <buffer> <F3> :w !detex \| wc -w<CR>
inoremap <buffer> <F3> <Esc>:w !detex \| wc -w<CR>
" Code snippets
inoremap <buffer> ;fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
inoremap <buffer> ;em \emph{}<++><Esc>T{i
inoremap <buffer> ;bf \textbf{}<++><Esc>T{i
" Surround visual selection with parenthesis
vnoremap <buffer> ; <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
inoremap <buffer> ;it \textit{}<++><Esc>T{i
inoremap <buffer> ;ct \textcite{}<++><Esc>T{i
inoremap <buffer> ;cp \parencite{}<++><Esc>T{i
inoremap <buffer> ;ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
inoremap <buffer> ;ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
inoremap <buffer> ;li <Enter>\item<Space>
inoremap <buffer> ;ref \ref{}<Space><++><Esc>T{i
" Render a table
inoremap <buffer> ;tab <Enter>\begin{table}[h!]<Enter>\centering<Enter>\begin{tabular}{c<c-o>3a\|c<Esc>a}<Enter>\hline<Enter><++><c-o>3a<Space>&<Space><++><Esc>a<Space>\\<Enter>\hline<Enter>\end{tabular}<Enter>\caption{<++>}<Enter>\label{tbl:<++>}<Enter>\end{table}<Enter><Esc>{
inoremap <buffer> ;a \href{}{<++>}<Space><++><Esc>2T{i
inoremap <buffer> ;sc \textsc{}<Space><++><Esc>T{i
inoremap <buffer> ;chap \chapter{}<Enter><Enter><++><Esc>2kf}i
inoremap <buffer> ;sec \section{}<Enter><Enter><++><Esc>2kf}i
inoremap <buffer> ;ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
inoremap <buffer> ;sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
" Place a star behind opening curly brace
inoremap <buffer> ;st <Esc>F{i*<Esc>f}i
inoremap <buffer> ;up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
nnoremap <buffer> ;up /usepackage<Enter>o\usepackage{}<Esc>i
inoremap <buffer> ;nu $\varnothing$
inoremap <buffer> ;col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
inoremap <buffer> ;rn (\ref{})<++><Esc>F}i
