source ~/dotfiles/config/nvim/options.vim
source ~/dotfiles/config/nvim/mapping.vim
source ~/dotfiles/config/nvim/plugins.vim
source ~/dotfiles/config/nvim/languages.vim

" enable mouse in all modes
set mouse=a

" colorscheme flattened_dark
colorscheme spartan
set background=dark

" obvious trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" colorcolumn
set colorcolumn=80
highlight ColorColumn ctermbg=Black

autocmd! BufWritePost * Neomake

" Fix color of warning, without this it's barely visible
:highlight NeomakeWarningMessage ctermfg=227
let g:neomake_warning_sign={'text': '⚠', 'texthl': 'NeomakeWarningMessage'}
