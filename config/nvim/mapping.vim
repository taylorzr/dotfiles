" Easy config reloading
command! Reload source $MYVIMRC

" Switch ; & :
" Quicker access to command mode
nnoremap ; :
vnoremap ; :
nnoremap : ;
vnoremap : ;

" Clear search highlighting
nnoremap <CR> :nohlsearch<CR>

" Jump to beginning/end of line
noremap H ^
noremap L $

" Copy filename and/or line number
nnoremap <Leader>cf :let @*=expand('%') \| echo 'Filename copied to clipboard!'<CR>
nnoremap <Leader>cl :let @*=expand('%') . ':' . line('.') \| echo 'Filename & line copied to clipboard!'<CR>
nnoremap <Leader>tf :Testfile<CR> \| :echo 'Testing ' . expand('%')<CR>
nnoremap <Leader>tl :Testline<CR> \| :echo 'Testing ' . expand('%') . ':' . line('.')<CR>
command! Testfile silent exec '!tmux send-keys -t 1 ber' . '\ ' . expand('%') . ' Enter'
command! Testline silent exec '!tmux send-keys -t 1 ber' . '\ ' . expand('%') . ':' . line('.') . ' Enter'

" Easier indent/dedent
nnoremap > >>
nnoremap < <<

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
