" Start scrolling before cursor reaches edge of screen
set scrolloff=10

" Show trailing tabs and spaces
set list listchars=tab:\▸\ ,trail:·

" Automatically wrap text
set textwidth=80
set fo+=t

" Expand tabs to spaces
set tabstop=4
set shiftwidth=2
set expandtab

" Use system clipboard for yanking
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif

" Turn off swap files
set noswapfile

" Persistent undo
set undofile
