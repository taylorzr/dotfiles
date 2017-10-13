let mapleader="\<Space>"

" Easy config reloading
command! Reload source $MYVIMRC
noremap <Leader>r :Reload<CR>

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

