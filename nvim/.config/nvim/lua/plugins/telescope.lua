return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    lazy = false,
    dependencies = { 
        {'nvim-lua/plenary.nvim'},
        {'BurntSushi/ripgrep'},
    },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', function() builtin.find_files({ hidden = true, file_ignore_patterns = { ".git/" } }) end, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)

        require('telescope').setup {
            defaults = {
                preview = {
                    treesitter = false
                }
            },
        }
    end,
}
