require('plugins')

vim.g.mapleader = ' '
vim.keymap.set("n", "<leader>q", "<cmd>bd<cr>")
vim.keymap.set("n", "<leader>Q", "<cmd>qa<cr>")
vim.keymap.set({"n", "i"}, "<C-s>", "<cmd>write<cr>")

vim.keymap.set("i", "<C-a>", "<C-o>^")
vim.keymap.set("i", "<C-e>", "<C-o>$")

-- move this into config block for plugin?
-- it wasn't working for some reason though
-- :LspInfo in a go file should show a client connected
vim.cmd('autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)')
vim.cmd('autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 1000)')
-- vim.cmd('autocmd FileType go setlocal omnifunc=v:lua.vim.lsp.omnifunc')
-- TODO autoimports
