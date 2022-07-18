require('plugins')

-- TODO
-- test octo, see docs https://github.com/pwntester/octo.nvim#-examples
-- maybe switch cmp accept to tab, using enter is goofy when you're trying to just insert a newline
-- maybe suda for sudo writing https://github.com/lambdalisue/suda.vim/

-- use system clipboard for yank/paste
if vim.fn.has('macunix') then
	vim.opt.clipboard = 'unnamedplus'
else
	vim.opt.clipboard = 'unnamed'
end

vim.g.mapleader = ' '

-- this might be a stupid setting, but i'm trying to diff between tabs and spaces
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.textwidth = 100

-- keymaps
vim.keymap.set("n", "<leader>q", "<cmd>bd<cr>")
vim.keymap.set({ "n", "i" }, "<C-s>", "<cmd>write<cr>")
-- terminal like begin/end line in insert mode
vim.keymap.set("i", "<C-a>", "<C-o>^")
vim.keymap.set("i", "<C-e>", "<C-o>$")
-- easier in/dedent
vim.keymap.set("n", ">", ">>")
vim.keymap.set("n", "<", "<<")
vim.keymap.set("n", "<leader>f", "<cmd>Lexplore<CR>")


-- languag specific
-- TODO autoimports for golang at least
-- it kinda works if you type a package name it adds it
-- but if you remove a package it doesn't pull it out
vim.cmd('autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)')
-- FIXME: autofmt lua keeps asking for which language server
-- vim.cmd('autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 1000)')

vim.cmd('autocmd Filetype rb lua vim.opt_local.expandtab = true')


