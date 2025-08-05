return require('lazy').setup({
  -- Put plugins without config here
  'machakann/vim-sandwich',
  'tpope/vim-eunuch', -- helpers for file commands like mv, rm, chmod
  'elihunter173/dirbuf.nvim',
  'preservim/tagbar',
  'towolf/vim-helm',
  'windwp/nvim-ts-autotag',
  'stevanmilic/nvim-lspimport', -- NOTE: really just helper for pyright imports

  -- plugins with config here

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "ibhagwan/fzf-lua" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})
    end
  },
  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  },

  {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("catppuccin").setup()
      vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
      -- vim.cmd [[colorscheme catppuccin]]
    end
  },

  {
    "zenbones-theme/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    -- you can set set configuration options here
    config = function()
      vim.g.zenbones_darken_comments = 45
      vim.cmd.colorscheme('kanagawabones')
    end
  },

  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },
  {
    'junegunn/vim-easy-align',
    config = function()
      vim.cmd([[
      nmap ga <Plug>(EasyAlign)
      xmap ga <Plug>(EasyAlign)
      ]])
    end
  },

  {
    'tpope/vim-fugitive',
    dependencies = {
      'tpope/vim-rhubarb',
    },
  },

  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
  },

  {
    'saadparwaiz1/cmp_luasnip',
    config = function()
      vim.cmd([[
      imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
      " -1 for jumping backwards.
      inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

      snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
      snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

      ]])
    end,
  },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   -- event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({
  --       suggestion = { enabled = false },
  --       panel = { enabled = false },
  --     })
  --   end,
  -- },
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end
  -- },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      vim.opt.completeopt = { "menu", "menuone", "noselect" }

      local cmp = require("cmp")
      local luasnip = require("luasnip")
      -- local has_words_before = function()
      --   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      --   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      -- end
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "copilot",                group_index = 2 },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'nvim_lua' },
          { name = 'buffer',                 option = { keyword_length = 4 } },
        }),
        experimental = {
          ghost_text = true
        }
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
          { name = 'buffer' },
        })
      })
    end
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },

  {
    'lukas-reineke/lsp-format.nvim',
    config = function()
      require("lsp-format").setup {}

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          require("lsp-format").on_attach(client, args.buf)
        end,
      })
    end
  },

  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    config = function()
      local null_ls = require("null-ls")
      -- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      null_ls.setup({
        -- See sources here:
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
        sources = {
          -- spell seems like its just annoying
          -- null_ls.builtins.completion.spell,
          -- null_ls.builtins.diagnostics.shellcheck.with({
          -- 	diagnostics_format = "[#{c}] #{m} (#{s})"
          -- }),
          null_ls.builtins.diagnostics.zsh,
          null_ls.builtins.formatting.black, -- python formatter
          null_ls.builtins.diagnostics.mypy, -- python "type" checker
          null_ls.builtins.formatting.isort, -- sorts python imports
          null_ls.builtins.formatting.prettier,
          -- null_ls.builtins.diagnostics.flake8 -- python linter
          -- https://github.com/DavidAnson/markdownlint/blob/main/doc/Rules.md#md013---line-length
          null_ls.builtins.diagnostics.markdownlint.with({ extra_args = { "--disable", "MD013" } }),
          -- WIP
          null_ls.builtins.formatting.sqlfluff.with({
            extra_args = { "--dialect", "mysql" },
          }),
          null_ls.builtins.diagnostics.sqlfluff.with({
            extra_args = { "--dialect", "mysql" },
          }),
        },

        -- https://github.com/nvimtools/none-ls.nvim/wiki/Formatting-on-save#code
        -- on_attach = function(client, bufnr)
        --   if client.supports_method("textDocument/formatting") then
        --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        --     vim.api.nvim_create_autocmd("BufWritePre", {
        --       group = augroup,
        --       buffer = bufnr,
        --       callback = function()
        --         vim.lsp.buf.formatting_sync()
        --       end,
        --     })
        --   end
        -- end,
      })
    end
  },

  {
    'knubie/vim-kitty-navigator',
    -- FIXME: run didn't work, instead ran
    -- cp ~/.local/share/nvim/site/pack/packer/start/vim-kitty-navigator/*.py ~/.config/kitty
    build = 'cp ./*.py ~/.config/kitty/',
    init = function()
      vim.cmd('nnoremap <silent> <C-left> :KittyNavigateLeft<cr>')
      vim.cmd('nnoremap <silent> <C-down> :KittyNavigateDown<cr>')
      vim.cmd('nnoremap <silent> <C-up> :KittyNavigateUp<cr>')
      vim.cmd('nnoremap <silent> <C-right> :KittyNavigateRight<cr>')
    end
  },

  -- https://github.com/lukas-reineke/indent-blankline.nvim
  -- visual indicators for what level scope you're in
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("ibl").setup()
    end
  }, -- lines for each indent level


  -- https://github.com/nvim-treesitter/nvim-treesitter-context
  -- shows what scope you're in when it's off the screen
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require 'treesitter-context'.setup {
        max_lines = 3,
      }
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()

      parser_config.gotmpl = {
        install_info = {
          url = "https://github.com/ngalaiko/tree-sitter-go-template",
          files = { "src/parser.c" }
        },
        filetype = "gotmpl",
        used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml" }
      }

      require 'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all"
        ensure_installed = { "lua", "go", "ruby", "python", "typescript" },

        -- Automatically cmpinstall missing parsers when entering buffer
        auto_install = true,

        -- v -> visual mode, then v/V to increment/decrement selection
        incremental_selection = {
          enable = true,
          keymaps = {
            node_incremental = "v",
            node_decremental = "V",
          },
        },

        highlight = {
          -- `false` will disable the whole extension
          enable = true,

          -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
          -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
          -- the name of the parser)
          -- list of language that will be disabled
          -- disable = { "c", "rust" },

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      }
    end
  },

  {
    'junegunn/fzf.vim',
    dependencies = {
      'junegunn/fzf',
    },
    config = function()
      -- ctrl-t is same as fzf in shell
      vim.cmd('nnoremap <C-t> <cmd>Files<cr>')
      vim.cmd('nnoremap <C-s-t> <cmd>Files ~/code/<cr>')
      vim.cmd("nnoremap <leader>r <cmd>Rg<CR>")
      -- NOTE: command same as FZF_DEFAULT_COMMAND without `--files`
      vim.cmd(
        'nnoremap <leader>g <cmd>call fzf#vim#grep("rg --hidden --glob \'!.git\'" . " -- " . expand("<cword>"), 1, fzf#vim#with_preview())<CR>')
    end
  },

  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require('dap')
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
      vim.keymap.set("n", "<leader>dc", dap.continue)
      vim.keymap.set("n", "<leader>do", dap.repl.open)
      vim.keymap.set("n", "<leader>si", dap.step_into)
      vim.keymap.set("n", "<leader>sn", dap.step_over)
      vim.keymap.set("n", "<leader>so", dap.step_out)
      dap.listeners.after.event_initialized["something"] = function()
        dap.repl.open()
      end

      dap.listeners.after.event_terminated["something"] = function()
        dap.repl.close()
      end
      dap.listeners.after.event_exited["something"] = function()
        dap.repl.close()
      end
    end
  },

  {
    'leoluz/nvim-dap-go',
    config = function()
      require('dap-go').setup()
    end

  },

  {
    'theHamsta/nvim-dap-virtual-text',
    config = function()
      require('nvim-dap-virtual-text').setup()
    end
  },

  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end

  },

  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require 'luasnip'.filetype_extend("go", { "go" })
      require 'luasnip'.filetype_extend("python", { "python" })
    end
  },

})
