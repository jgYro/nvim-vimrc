-- Set VIM defaults
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.g["far#enable_undo"] = 1
vim.g["far#highlight_match"] = true
vim.g["closetag_xhtml_filenames"] = '*.xhtml,*.jsx'
vim.g["closetag_filetypes"] = 'html,xhtml,phtml'
vim.g["closetag_xhtml_filetypes"] = 'xhtml,jsx'
vim.g["closetag_emptyTags_caseSensitive"] = 1
vim.g["closetag_shortcut"] = '>'
vim.g["python3_host_prog"] = "/Library/Frameworks/Python.framework/Versions/3.10/bin/python3"

options = { noremap = true }


-- Use spacebar as leader key
vim.g.mapleader = ' '

-- LSP logs
vim.api.nvim_set_keymap('n', '<leader>lsplog', '<cmd>lua vim.cmd(\'edit \'..vim.lsp.get_log_path())<CR>', options)

-- Run dart program
vim.api.nvim_set_keymap('n', '<leader>dart', '<cmd>:w<CR><cmd>!dart %<CR>', options)

-- Run python program
vim.api.nvim_set_keymap('n', '<leader>py', '<cmd>:w<CR><cmd>!python3 %<CR>', options)

-- Run rust program
vim.api.nvim_set_keymap('n', '<leader>rust', '<cmd>:w<CR><cmd>!cargo run % %<CR>', options)

-- Quickly edit vimrc
vim.api.nvim_set_keymap('n', '<leader>vimrc', '<cmd>e $MYVIMRC<CR>', options)

-- Quickly open terminal
vim.api.nvim_set_keymap('n', '<C-t>', '<cmd>split<CR><cmd>terminal<CR><C-w>j a', options)

-- Go back to normal mode in terminal
vim.api.nvim_set_keymap('t', '<C-n>', '<C-|><C-n>', options)

-- Use Ctrl-h,j,k,l to move between splits
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', options)
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', options)
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', options)
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', options)

-- Change size of splits
-- Height
vim.api.nvim_set_keymap('n', '<C-]>', '2<C-w>+', options)
vim.api.nvim_set_keymap('n', '<C-[>', '2<C-w>-', options)

-- Width
vim.api.nvim_set_keymap('n', '<leader>]', '16<C-w>>', options)
vim.api.nvim_set_keymap('n', '<leader>[', '16<C-w><', options)

-- Center each search result
vim.api.nvim_set_keymap('n', 'n', 'nzz', options)
vim.api.nvim_set_keymap('n', 'N', 'Nzz', options)

-- Neovim package manager
return require('packer').startup(function()

	-- Package manager manages itself
	use 'wbthomason/packer.nvim'

    -- Web Devicons
    use 'ryanoasis/vim-devicons'

    -- Neorg
    use { "nvim-neorg/neorg",
    config = function()
    end,
    requires = "nvim-lua/plenary.nvim"
}

    -- Better find and replace
    use 'brooth/far.vim'
    vim.api.nvim_set_keymap('n', '<leader>f/', '<cmd>Farf<CR>', options)
    vim.api.nvim_set_keymap('v', '<leader>f/', '<cmd>Far<CR>', options)
    vim.api.nvim_set_keymap('n', '<leader>fr/', '<cmd>Farr<CR>', options)
    vim.api.nvim_set_keymap('v', '<leader>fr/', '<cmd>:\'<,\'>Far<CR>', options)

    -- Colors
    use 'folke/lsp-colors.nvim'

    -- HTML tags
    use 'alvan/vim-closetag'

    -- Ultisnips
    use 'SirVer/ultisnips'
    use 'honza/vim-snippets'

    -- Colorscheme
    use 'ellisonleao/gruvbox.nvim'
    vim.cmd([[colorscheme gruvbox]])

    -- Copilot
    use 'github/copilot.vim'

    -- Fzf for Telescope
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- Comment stuff
    use 'tpope/vim-commentary'

    -- flutter
    use 'akinsho/flutter-tools.nvim'

	-- Treesitter
	use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'lewis6991/nvim-treesitter-context'
	use 'nvim-treesitter/nvim-treesitter-refactor'
	use 'nvim-treesitter/playground'
    use 'p00f/nvim-ts-rainbow'
    

	-- Highlight matched information
	use 'kevinhwang91/nvim-hlslens'

    -- Always find the cursor
    use 'danilamihailov/beacon.nvim'
    vim.g.beacon_minimal_jump = 5

	-- surrounding quotes, paranthese and what not
	use 'jiangmiao/auto-pairs'

	-- Easily delete, change and add surroundings in pairs
	use 'tpope/vim-surround'

    -- LSP Formatter
    use "lukas-reineke/lsp-format.nvim"

	-- Multi cursor
	use 'mg979/vim-visual-multi'

    -- Snippets
    use 'hrsh7th/vim-vsnip'

    -- Rust support
    use 'simrat39/rust-tools.nvim'

	--
	--
	--
	-- Important Telescope plugins/setups
	--
	--
	--
    use 'nvim-telescope/telescope-media-files.nvim'
    use 'fhill2/telescope-ultisnips.nvim'
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    require('telescope').load_extension('fzf')
    require('telescope').load_extension('ultisnips')

    -- Telescope stuff
    vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>Telescope<cr>', options)

    -- List files in current directory
    vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', options)

    -- Search for a string in current working directory and get live results
    vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', options)

    -- List manpage entries
    vim.api.nvim_set_keymap('n', '<leader>fm', '<cmd>Telescope man_pages<cr>', options)

    -- List function names, variables from Treesitter
    vim.api.nvim_set_keymap('n', '<leader>fts', '<cmd>Telescope treesitter<cr>', options)

    -- List diagnostics for all open buffers
    vim.api.nvim_set_keymap('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>', options)

    -- List LSP references for word under the cursor
    vim.api.nvim_set_keymap('n', '<leader>fr', '<cmd>Telescope lsp_references<cr>', options)

	--
	--
	--
	-- Important Autocompletion/LSP plugins/setups
	--
	--
	--

	-- Neovim native LSP
	use 'neovim/nvim-lspconfig'

	-- Autocompletion plugin(s)
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'

	-- Setup nvim-cmp.
    local cmp = require'cmp'

    cmp.setup({
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
            end,
        },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'path' },
      { name = 'buffer' },

    })
    })
        -- Use buffer source for `/`
    cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
    })

    -- Use cmdline & path source for ':'
    cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
    })

    -- LSP Formmatter
    require("lsp-format").setup {}


    -- Setup lspconfig.
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.textDocument.completion.completionItem.snippetSupport = true


    -- on_attach for mapping keys only when the LSP attaches to the buffer
    local on_attach = function(client, bufnr)
        require "lsp-format".on_attach(client)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', options)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gv', '<cmd>vsplit<CR><cmd>lua vim.lsp.buf.definition()<CR>', options)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', options)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', options)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', options)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', options)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', options)
        vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', options)

    end


    require('lspconfig')['pylsp'].setup {
	    capabilities = capabilities,
	    on_attach = on_attach,
        settings = {
            pylsp = {
                plugins = {
                    jedi_completion = {
                        include_params = true,
                    }
                }
            }
        }
    }

    require("flutter-tools").setup{
        lsp = {
            on_attach = on_attach,
            capabilities = capabilities
        }
    }

    require('lspconfig')['bashls'].setup {
        lsp = {
            autostart = true,
        },
	    capabilities = capabilities,
	    on_attach = on_attach
    }

    require'lspconfig'.rust_analyzer.setup {
		tools = { 
		    autoSetHints = true,
		    hover_with_actions = true,
		    inlay_hints = {
			show_parameter_hints = false,
			parameter_hints_prefix = "",
			other_hints_prefix = "",
		    },
		},
        ["rust-client"] = {
                engine = "rust-analyzer",
            },
            settings = {
                rust = {
                    build_on_save = false,
                    ["rust-analyzer"] = {
                        completion = {
                            addCallArgumentSnippets = false,
                            addCallParenthesis = false,
                        },
                    },
                },
            },
	    capabilities = capabilities,
	    on_attach = on_attach
    }
    require'lspconfig'.sumneko_lua.setup {
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
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
    require'lspconfig'.vimls.setup{}
    require'nvim-treesitter.configs'.setup {
      ensure_installed = { "python", "lua", "rust", "dart", "bash" },

      sync_install = true,

      highlight = {

        enable = true,
        additional_vim_regex_highlighting = true,
      },
    rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
      },
    }
    require'lspconfig'.tailwindcss.setup{
        on_attach = on_attach,
        capabilities = capabilities,
        init_options = { userLanguages = { htmldjango = "html" }},
        settings = {
	    tailwindCSS = {
		    experimental = {
			    classRegex = {
                    "tailwind\\('([^)]*)\\')", "'([^']*)'"
		    	    },
		    },
	    },
    },
    }
    require'lspconfig'.html.setup{
        on_attach = on_attach,
        capabilities = capabilities
    }
    require'lspconfig'.dartls.setup{
        on_attach = on_attach,
        capabilities = capabilities
    }
    require('neorg').setup {
    load = {
        ["core.defaults"] = {},
        ["core.integrations.nvim-cmp"] = {},
        ["core.integrations.treesitter"] = {},
        ["core.gtd.ui"] = {},
        ["core.gtd.helpers"] = {},
        ["core.gtd.queries"] = {},
        ["core.norg.dirman"] = {
                    config = {
                        workspaces = {
                            work = "~/notes/work",
                            home = "~/notes/home",
                        }
                    }
                }
            }
        }


end)
