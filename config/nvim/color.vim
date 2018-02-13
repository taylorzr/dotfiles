" colorscheme flattened_dark
" (needs to come after loading plugins)
" colorscheme spartan
colorscheme fight-in-the-shade

" obvious trailing whitespace
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" colorcolumn
set colorcolumn=80
highlight ColorColumn ctermbg=Black

" Fix color of warning, without this it's barely visible
" highlight NeomakeWarningMessage ctermfg=227
" let g:neomake_warning_sign={'text': '⚠', 'texthl': 'NeomakeWarningMessage'}
