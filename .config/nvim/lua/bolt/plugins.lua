return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- TreeSitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Rose Pine color scheme
    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    })

    -- Material theme color scheme
    use('kaicataldo/material.vim', { branch= 'main', as = 'material' })

    -- UndoTree
    use('mbbill/undotree')

    -- Fugitive
    use('tpope/vim-fugitive')

    -- LSP Zero
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            {'neovim/nvim-lspconfig'},
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'}
        }
    }

    -- Comment
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
end)
