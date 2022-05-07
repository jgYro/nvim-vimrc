-- Set VIM defaults
vim.opt.clipboard = "unnamedplus"
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
options = { noremap = true }

-- Use spacebar as leader key
vim.g.mapleader = ' '

-- Quickly edit vimrc
vim.api.nvim_set_keymap('n', '<leader>vimrc', '<cmd>e $MYVIMRC<CR>', options)

function curl_to_buffer()
    request = vim.fn.input("Please enter curl request: ")
    vim.cmd(':enew | .!curl ' .. request .. '')
end

-- Output curl request to buffer
vim.api.nvim_set_keymap('n', '<leader>curl', '<cmd>lua curl_to_buffer()<CR>', options)

-- Run current lua file
vim.api.nvim_set_keymap('n', '<leader>lua', '<cmd>luafile %<CR>', options)

-- Quickly open terminal
vim.api.nvim_set_keymap('n', '<C-t>', '<cmd>split<CR><cmd>terminal<CR><C-w>j a', options)

-- Format json with python3 module
vim.api.nvim_set_keymap('n', '<leader>js', '<cmd>%!python3 -m json.tool<CR>', options)

-- XSoar upload new automation/yaml/playbook to xsoar
vim.api.nvim_set_keymap('n', '<leader>xup', '<cmd>!demisto-sdk upload -i . --verbose<CR>', options)

function pass_string_to_cli()
    user = vim.fn.input("Command to run: ")
    command = '"' .. user .. '"'
    vim.cmd(':! demisto-sdk run -q ' .. command .. '')
end

-- Could be dope
vim.api.nvim_set_keymap('n', '<leader>xec', '<cmd>lua pass_string_to_cli()<CR>', options)

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

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- Highlight matched information
    use 'kevinhwang91/nvim-hlslens'

    -- Always find the cursor
    use 'danilamihailov/beacon.nvim'
    vim.g.beacon_minimal_jump = 5

    -- surrounding quotes, paranthese and what not
    use 'jiangmiao/auto-pairs'

    -- Easily delete, change and add surroundings in pairs
    use 'tpope/vim-surround'

    -- Multi cursor
    use 'mg979/vim-visual-multi'

    --
    --
    --
    -- Important Telescope plugins/setups
    --
    --
    --
    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
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
    local cmp = require 'cmp'

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

    -- on_attach for mapping keys only when the LSP attaches to the buffer
    local on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', options)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', options)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', options)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', options)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', options)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', options)
        vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', options)

    end


    -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
    require('lspconfig')['pyright'].setup {
        capabilities = capabilities,
        on_attach = on_attach
    }

    require('lspconfig')['bashls'].setup {
        capabilities = capabilities, on_attach = on_attach
    }

    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    require('lspconfig')['sumneko_lua'].setup {
        capabilities = capabilities, on_attach = on_attach,
        cmd = { "/home/yro/lua-language-server/bin/lua-language-server" },
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                    -- Setup your lua path
                    path = runtime_path,
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

end)
