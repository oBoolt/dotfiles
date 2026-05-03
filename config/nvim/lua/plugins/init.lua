require("plugins.lsp")
require("plugins.dap")

vim.pack.add({
    "g:ellisonleao/gruvbox.nvim",
    "g:tpope/vim-fugitive",
    "g:numToStr/Navigator.nvim",
    "g:nvim-lua/plenary.nvim",
    "g:BurntSushi/ripgrep",
    "g:nvim-telescope/telescope-fzf-native.nvim",
    "g:nvim-treesitter/nvim-treesitter",
    "g:nvim-telescope/telescope.nvim",
    "g:mbbill/undotree",
    "g:MagicDuck/grug-far.nvim",
    "g:echasnovski/mini.nvim",
    "g:MeanderingProgrammer/render-markdown.nvim",
    "g:code-biscuits/nvim-biscuits",
})

require("Navigator").setup()
require("telescope").setup()
require("render-markdown").setup()
require("nvim-biscuits").setup()

vim.cmd.colorscheme("gruvbox")

-- Telescope
local telescope = require("telescope.builtin")
vim.keymap.set('n', '<leader>pf',
    function() telescope.find_files({ hidden = true, file_ignore_patterns = { ".git/" } }) end, {})
vim.keymap.set('n', '<C-p>', telescope.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    telescope.grep_string({ search = vim.fn.input("Grep > ") })
end)

-- Undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Treesitter
local langs = { 'rust', 'javascript', 'typescript', 'java', 'javadoc', 'css', 'scss', 'qmljs' }
require('nvim-treesitter').install(langs);
vim.api.nvim_create_autocmd('FileType', {
    pattern = langs,
    callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
});
