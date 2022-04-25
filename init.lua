-- Set VIM defaults
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Use spacebar as leader key
vim.g.setleader = ' '

-- Use Ctrl-h,j,k,l to move between splits
vim.keymap.set('n', '<C-h>', '<C-w>h', options)
vim.keymap.set('n', '<C-j>', '<C-w>j', options)
vim.keymap.set('n', '<C-k>', '<C-w>k', options)
vim.keymap.set('n', '<C-l>', '<C-w>l', options)

-- Center each search result
vim.keymap.set('n', 'n', 'nzz', options)
vim.keymap.set('n', 'N', 'Nzz', options)

-- Neovim package manager
return require('packer').startup(function()

	-- Package manager manages itself
	use 'wbthomason/packer.nvim'

	-- Treesitter
	use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }


	-- Highlight matched information
	use 'kevinhwang91/nvim-hlslens'

	-- surrounding quotes, paranthese and what not
	use 'jiangmiao/auto-pairs'

	-- Easily delete, change and add surroundings in pairs
	use 'tpope/vim-surround'

	-- Multi cursor
	use 'mg979/vim-visual-multi'

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
	    snippet = {},
	    window = {
	      -- completion = cmp.config.window.bordered(),
	      -- documentation = cmp.config.window.bordered(),
	    },
	    mapping = cmp.mapping.preset.insert({
	      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
	      ['<C-f>'] = cmp.mapping.scroll_docs(4),
	      ['<C-Space>'] = cmp.mapping.complete(),
	      ['<C-e>'] = cmp.mapping.abort(),
	      -- Accept currently selected item. 
	      -- Set `select` to `false` to confirm explicitly selected items
	      ['<CR>'] = cmp.mapping.confirm({ select = true }),
	    }),
	    sources = cmp.config.sources({
	      { name = 'nvim_lsp' },
	      -- { name = 'luasnip' }, -- For luasnip users.
	      -- { name = 'ultisnips' }, -- For ultisnips users.
	      -- { name = 'snippy' }, -- For snippy users.
	    }, {
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

	  -- Setup lspconfig.
	  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
	  
	  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
	  require('lspconfig')['pyright'].setup {
	    capabilities = capabilities
	  }

end)
