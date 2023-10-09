
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
vim.g.maplocalleader = ','

-- this might be a stupid setting, but i'm trying to diff between tabs and spaces
vim.opt.tabstop = 3
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.textwidth = 100
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- show and highlight trailing whitespace
vim.opt.list = true
-- FIXME
-- vim.cmd("match errorMsg /\\s+$/")
-- vim.cmd("autocmd ColorScheme * highlight errorMsg ctermbg=red guibg=red")


-- keymaps
vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>")
vim.keymap.set({ "n", "i" }, "<C-s>", "<cmd>write<cr>")
-- terminal like begin/end line in insert mode
vim.keymap.set("i", "<C-a>", "<C-o>^")
vim.keymap.set("i", "<C-e>", "<C-o>$")
-- easier in/dedent
vim.keymap.set("n", ">", ">>")
vim.keymap.set("n", "<", "<<")
-- don't jump to next match when using *
vim.keymap.set("n", "*","<cmd>keepjumps normal! mi*`i<CR>")

-- leader keymaps
vim.keymap.set("n", "<leader>ni", "<cmd>Neorg index<cr>")
vim.keymap.set("n", "<leader>nr", "<cmd>Neorg return<cr>")
vim.keymap.set("n", "<leader>cn", "<cmd>cn<cr>")
vim.keymap.set("n", "<leader>cp", "<cmd>cp<cr>")
vim.keymap.set("n", "<leader>cl", "<cmd>ccl<cr>")
vim.keymap.set("n", "<leader>ei", "<cmd>e ~/.config/nvim/init.lua<cr>")
vim.keymap.set("n", "<leader>ep", "<cmd>e ~/.config/nvim/lua/plugins.lua<cr>")
vim.keymap.set("n", "<leader>v", "<cmd>vsplit<CR>")
vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<CR>")

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.api.nvim_create_augroup("zachwuzhere", { clear = true })

-- language specific

-- golang
vim.api.nvim_create_autocmd("Filetype", {
  group = "zachwuzhere",
  pattern = { "go" },
  callback = function()
    vim.keymap.set("n", "<leader>p", "oruntime.Breakpoint()<ESC>")
    vim.opt_local.shiftwidth = 3
    vim.opt_local.expandtab = false
  end
})

-- FIXME: this thought this lua file was gotmpl, and i dont think this works anywho, probably just
-- delete
-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
--   group = "zachwuzhere",
--   pattern = { "*" },
--   callback = function()
--     vim.cmd([[if search('{{.\+}}', 'nw') | setlocal filetype=gotmpl | endif]])
--   end
-- })

-- https://github.com/neovim/nvim-lspconfig/issues/115#issuecomment-1130373799
vim.api.nvim_create_autocmd("BufWritePre", {
  group = "zachwuzhere",
  pattern = { "*.go" },
  callback = function()
    vim.lsp.buf.format(nil, 1000)
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = "zachwuzhere",
  pattern = { "*.go" },
  callback = function()
    local params = vim.lsp.util.make_range_params(nil, "utf-16")
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 5000)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
  end,
})


-- lua
vim.api.nvim_create_autocmd("BufWritePre", {
  group = "zachwuzhere",
  pattern = { "*.lua" },
  callback = function()
    vim.lsp.buf.format(nil, 1000)
  end
})


-- ruby
vim.g.ruby_indent_assignment_style = "variable"

vim.api.nvim_create_autocmd("Filetype", {
  group = "zachwuzhere",
  pattern = { "ruby" },
  callback = function()
    vim.keymap.set("n", "<leader>p", "orequire 'pry'; binding.pry<ESC>")
    vim.opt_local.expandtab = true
  end
})


-- python
vim.api.nvim_create_autocmd("Filetype", {
  group = "zachwuzhere",
  pattern = { "python" },
  callback = function()
    vim.keymap.set("n", "<leader>p", "oimport code; code.interact(local=dict(globals(), **locals()))<ESC>")
    vim.opt_local.shiftwidth = 4
  end
})

-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = "zachwuzhere",
--   pattern = { "*.rb" },
--   callback = function()
--     vim.lsp.buf.format(nil, 5000)
--   end
-- })


-- terraform
vim.api.nvim_create_autocmd("BufWritePre", {
  group = "zachwuzhere",
  pattern = { "*.tf", "*.tfvars" },
  callback = function()
    vim.lsp.buf.format(nil, 10000)
  end
})

-- groovy
-- autocmd BufNewFile,BufRead *jenkinsfile* set filetype=groovy
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = "zachwuzhere",
  pattern = { "*jenkinsfile*" },
  callback = function()
    vim.o.filetype = "groovy"
  end
})

-- devicetree
-- (zmk keymap filetype)
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = "zachwuzhere",
  pattern = { "*.keymap" },
  callback = function()
    vim.o.filetype = "devicetree"
  end
})

-- os dependent
if vim.fn.has('macunix') then
  vim.opt.clipboard = 'unnamedplus'
  vim.keymap.set("n", "<leader>cf", "<cmd>let @*=expand('%') | echo 'path copied to clipboard!'<CR>")
  vim.keymap.set("n", "<leader>ca", "<cmd>let @*=expand('%:p') | echo 'absolute path copied to clipboard!'<CR>")
  vim.keymap.set("n", "<leader>cl",
    "<cmd>let @*=expand('%') . ':' . line('.') | echo 'filename:line copied to clipboard!'<CR>")
else
  vim.opt.clipboard = 'unnamed'
  -- TODO: maybe only have yank go to system clipboard?
  -- so like delete would go to vim only clipboard
  -- to avoid putting spam on clipboard
  -- so then could only paste into vim with like ctrl-shift-v
  -- vim.cmd('nnoremap y "*y')
  -- vim.cmd('vnoremap y "*y')
  vim.keymap.set("n", "<leader>cf", "<cmd>let @+=expand('%') | echo 'path copied to clipboard!'<CR>")
  vim.keymap.set("n", "<leader>ca", "<cmd>let @+=expand('%:p') | echo 'absolute path copied to clipboard!'<CR>")
  vim.keymap.set("n", "<leader>cl",
    "<cmd>let @+=expand('%') . ':' . line('.') | echo 'filename:line copied to clipboard!'<CR>")
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- lua/plugins.lua
require('plugins')
