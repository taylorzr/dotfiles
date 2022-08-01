require('plugins')

-- TODO
-- test octo, see docs https://github.com/pwntester/octo.nvim#-examples
--   meh seems a bit complicated, maybe try some more to get used to it?
-- maybe suda for sudo writing https://github.com/lambdalisue/suda.vim/
--
-- NOTES
-- * linking to github via vim-fugitive :GB is very convenient
-- * plugin for commenting is very convenient
-- * plugin for delete/rename files is convenient
--   maybe there are easy builtin ways though?

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
-- TODO: Run goimports something like this
-- :%! goimports
-- or maybe use https://github.com/fatih/vim-go
vim.cmd('autocmd Filetype go nnoremap <Leader>p oruntime.Breakpoint()<ESC>')
-- FIXME: autofmt lua keeps asking for which language server
-- vim.cmd('autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 1000)')

vim.cmd('autocmd Filetype ruby lua vim.opt_local.expandtab = true')
vim.cmd("autocmd Filetype ruby nnoremap <Leader>p orequire 'pry'; binding.pry<ESC>")

-- https://www.getman.io/posts/programming-go-in-neovim/
-- not working exactly, close tho
function Goimports(timeout_ms)
	local context = { source = { organizeImports = true } }
	vim.validate { context = { context, "t", true } }

	local params = vim.lsp.util.make_range_params()
	params.context = context

	-- See the implementation of the textDocument/codeAction callback
	-- (lua/vim/lsp/handler.lua) for how to do this properly.
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
	if not result or next(result) == nil then return end
	local actions = result[1].result
	print(string.format("len of actions is %d\n", #actions))
	if not actions then return end
	local action = actions[1]

	-- textDocument/codeAction can return either Command[] or CodeAction[]. If it
	-- is a CodeAction, it can have either an edit, a command or both. Edits
	-- should be executed first.
	if action.edit --[[ and not next(action.edit) ]] or type(action.command) == "table" then
		if action.edit then
		-- 	for a,b in ipairs(action.edit) do
		-- 		print(a,b)
		-- 	end
			vim.lsp.util.apply_workspace_edit(action.edit)
		end
		if type(action.command) == "table" then
			vim.lsp.buf.execute_command(action.command)
		end
	else
		vim.lsp.buf.execute_command(action)
	end
end


-- os dependent
if vim.fn.has('macunix') then
	vim.opt.clipboard = 'unnamedplus'
	vim.keymap.set("n", "<leader>cf", "<cmd>let @*=expand('%') | echo 'path copied to clipboard!'<CR>")
	vim.keymap.set("n", "<leader>ca", "<cmd>let @*=expand('%:p') | echo 'absolute path copied to clipboard!'<CR>")
	vim.keymap.set("n", "<leader>cl", "<cmd>let @*=expand('%') . ':' . line('.') | echo 'filename:line copied to clipboard!'<CR>")
else
	vim.opt.clipboard = 'unnamed'
	vim.keymap.set("n", "<leader>cf", "<cmd>let @+=expand('%') | echo 'path copied to clipboard!'<CR>")
	vim.keymap.set("n", "<leader>ca", "<cmd>let @+=expand('%:p') | echo 'absolute path copied to clipboard!'<CR>")
	vim.keymap.set("n", "<leader>cl", "<cmd>let @+=expand('%') . ':' . line('.') | echo 'filename:line copied to clipboard!'<CR>")
end
