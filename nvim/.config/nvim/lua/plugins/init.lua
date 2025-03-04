return {
    { 
        'numToStr/Comment.nvim',
        opts = {
            mappings = {
                basic = true,
                extra = true,
            },
        },
    },
    { 
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            terminal_colors = true,
        },
        config = function()
            vim.o.background = "dark"
            vim.cmd.colorscheme("gruvbox")
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end,
    },
    { 
        'mbbill/undotree',
        init = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end,
    },
    {
        'tpope/vim-fugitive',
        init = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        end
    },
    {
        'nvim-java/nvim-java',
        config = function()
            require('java').setup()
            require('lspconfig').jdtls.setup({})
        end
    }
}

