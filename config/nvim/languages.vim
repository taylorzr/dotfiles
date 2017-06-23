" Ruby 
autocmd Filetype ruby setlocal shiftwidth=2
autocmd Filetype ruby nnoremap <Leader>p orequire 'pry'; binding.pry<ESC>

" Elixir
autocmd Filetype elixir nnoremap <Leader>p orequire IEx; IEx.pry<ESC>

" Python
autocmd Filetype python nnoremap <Leader>p ofrom IPython import embed; embed()<ESC>

" Go
autocmd FileType go setlocal noexpandtab

" Make
autocmd FileType make setlocal noexpandtab
