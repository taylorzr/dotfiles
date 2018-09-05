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

" Easier indent/dedent
nnoremap > >>
nnoremap < <<

" Folding
nnoremap <Space> za

" Easier saving
nnoremap <C-s> :update<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Copy/run tests by filename or line number
if system('uname -s') == "Darwin\n"
  nnoremap <Leader>cf :let @*=expand('%') \| echo 'Filename copied to clipboard!'<CR>
  nnoremap <Leader>cl :let @*=expand('%') . ':' . line('.') \| echo 'Filename & line copied to clipboard!'<CR>
else
  nnoremap <Leader>cf :let @+=expand('%') \| echo 'Filename copied to clipboard!'<CR>
  nnoremap <Leader>cl :let @+=expand('%') . ':' . line('.') \| echo 'Filename & line copied to clipboard!'<CR>
endif

nnoremap <Leader>ta :Testall<CR> \| :echo 'Testing all the things'<CR>
nnoremap <Leader>tf :Testfile<CR> \| :echo 'Testing ' . expand('%')<CR>
nnoremap <Leader>tl :Testline<CR> \| :echo 'Testing ' . expand('%') . ':' . line('.')<CR>
command! Testall silent exec '!tmux send-keys -t 1 run-tests ENTER'
command! Testfile silent exec '!tmux send-keys -t 1 run-tests' . '\ ' . expand('%') . ' Enter'
command! Testline silent exec '!tmux send-keys -t 1 run-tests' . '\ ' . expand('%') . ':' . line('.') . ' Enter'
