" colorscheme flattened_dark
" (needs to come after loading plugins)
colorscheme spartan
set background=dark

" obvious trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" colorcolumn
set colorcolumn=80
highlight ColorColumn ctermbg=Black

" Fix color of warning, without this it's barely visible
:highlight NeomakeWarningMessage ctermfg=227
let g:neomake_warning_sign={'text': '⚠', 'texthl': 'NeomakeWarningMessage'}

