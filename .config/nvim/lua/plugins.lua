return require('packer').startup(function(use)
  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("catppuccin").setup()
      vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
      vim.cmd [[colorscheme catppuccin]]
    end
  }
  use {
    'wbthomason/packer.nvim',

    config = function()
      vim.cmd([[
      augroup packer_user_config
      autocmd!
      autocmd BufWritePost plugins.lua source <afile> | PackerCompile
      augroup end
      ]])

    end
  }

  -- Put plugins without config here
  use "lukas-reineke/indent-blankline.nvim" -- lines for each indent level
  use 'machakann/vim-sandwich'
  use 'tpope/vim-eunuch' -- helpers for file commands like mv, rm, chmod

  use {
    'junegunn/vim-easy-align',
    config = function()
      vim.cmd([[
      nmap ga <Plug>(EasyAlign)
      xmap ga <Plug>(EasyAlign)
      ]])
    end
  }

  use {
    'tpope/vim-fugitive',
    requires = {
      'tpope/vim-rhubarb',
    },
  }

  use 'L3MON4D3/LuaSnip'
  use {
    'saadparwaiz1/cmp_luasnip',
    config = function()
      vim.cmd([[
      imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
      " -1 for jumping backwards.
      inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

      snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
      snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

      ]])
    end
  }
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp'

  use {
    'hrsh7th/nvim-cmp',
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

          ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif cmp.visible() then
              cmp.confirm({ select = true }) -- ({ select = true }) maybe?
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'nvim_lua' },
          { name = 'buffer', option = { keyword_length = 4 } },
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
  }

  -- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  use {
    'neovim/nvim-lspconfig',
    config = function()
      local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- FIXME: probably should just map these globally
      -- I guess if we have a file where lsp isn't running it would error but maybe that's good
      local on_attach = function()
        -- print("hello bro") -- used to test if this is being loaded
        -- see options with :h vim.lsp.buf....
        -- buffer = 0 means set for current buffer
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
        vim.keymap.set("n", "gn", vim.lsp.diagnostic.goto_next, { buffer = 0 })
        vim.keymap.set("n", "gp", vim.lsp.diagnostic.goto_prev, { buffer = 0 })
        vim.keymap.set("n", "gl", "<cmd>Telescope diagnostics<cr>", { buffer = 0 })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })
        vim.keymap.set("n", "gR", vim.lsp.buf.rename, { buffer = 0 })
        vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { buffer = 0 })
      end

      local lsp = require('lspconfig')

      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
      lsp.gopls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
      }

      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#solargraph
      lsp.solargraph.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        formatting = false, -- this is just not what i want most the time
        settings = {
          solargraph = {
            diagnostics = false --pretty noisy, can tune?
          }
        }
      })

      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
      lsp.pylsp.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          pylsp = {
            plugins = {
              pycodestyle = {
                ignore = { 'W391' },
                maxLineLength = 100
              }
            }
          }
        }
      }

      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#terraformls
      lsp.terraformls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
      }

      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sqlls
      lsp.sqlls.setup {}

      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls
      lsp.bashls.setup {}

      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls
      -- lsp.yamlls.setup {
      -- 	-- ... -- other configuration for setup {}
      -- 	settings = {
      -- 		yaml = {
      -- 			-- ... -- other settings. note this overrides the lspconfig defaults.
      -- 			schemas = {
      -- 				-- ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
      -- 				-- ["../path/relative/to/file.yml"] = "/.github/workflows/*",
      -- 				-- ["/path/from/root/of/project"] = "/.github/workflows/*",
      -- 			},
      -- 		},
      -- 	}
      -- }

      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
      lsp.sumneko_lua.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { 'vim' },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
          },
        },
      }
    end
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- spell seems like its just annoying
          -- null_ls.builtins.completion.spell,
          -- null_ls.builtins.diagnostics.shellcheck.with({
          -- 	diagnostics_format = "[#{c}] #{m} (#{s})"
          -- }),
          null_ls.builtins.diagnostics.zsh,
        },
      })
    end
  }

  use {
    'alexghergh/nvim-tmux-navigation',
    config = function()
      require 'nvim-tmux-navigation'.setup {
        disable_when_zoomed = true, -- defaults to false
        keybindings = {
          left = "<C-h>",
          down = "<C-j>",
          up = "<C-k>",
          right = "<C-l>",
          last_active = "<C-\\>",
        }
      }
    end
  }

  use 'nvim-treesitter/nvim-treesitter-context'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
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
        ensure_installed = { "lua", "go", "ruby", "python" },

        -- Automatically cmpinstall missing parsers when entering buffer
        auto_install = true,

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
  }

  -- Lua
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end
  }

  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  use {
    'junegunn/fzf',
    config = function()
      -- vim.cmd('fzf#install()') -- FIXME this errors
      vim.cmd('nnoremap <leader>r <cmd>Rg<cr>')
    end
  }
  use { 'junegunn/fzf.vim' }

  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      vim.cmd('nnoremap <C-p> <cmd>Telescope find_files<cr>')
      vim.cmd('nnoremap <leader>ff <cmd>Telescope find_files<cr>')
      vim.cmd('nnoremap <leader>fg <cmd>Telescope live_grep<cr>')
      vim.cmd('nnoremap <leader>fw <cmd>Telescope grep_string<cr>')
      vim.cmd('nnoremap <leader>fb <cmd>Telescope buffers<cr>')
      vim.cmd('nnoremap <leader>fh <cmd>Telescope help_tags<cr>')

      -- local actions = require("telescope.actions")
      local trouble = require("trouble.providers.telescope")
      local telescope = require("telescope")

      telescope.setup {
        defaults = {
          mappings = {
            i = { ["<c-t>"] = trouble.open_with_trouble },
            n = { ["<c-t>"] = trouble.open_with_trouble },
          },
        },
      }

      telescope.load_extension('fzf')
    end,
  }


  use {
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
  }

  use {
    'leoluz/nvim-dap-go',
    config = function()

      require('dap-go').setup()
    end

  }

  use {
    'theHamsta/nvim-dap-virtual-text',
    config = function()
      require('nvim-dap-virtual-text').setup()
    end
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end

  }

  use {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require 'luasnip'.filetype_extend("go", { "go" })
      require 'luasnip'.filetype_extend("ruby", { "rails" })
      -- TODO python
    end
  }

  use {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require "octo".setup()
    end
  }
end)
