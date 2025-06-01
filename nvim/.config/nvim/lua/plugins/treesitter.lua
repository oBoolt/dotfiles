return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    config = function() 
        langs = { 'rust', 'javascript', 'typescript', 'java', 'javadoc', 'css', 'scss' }
        require('nvim-treesitter').install(langs);
        vim.api.nvim_create_autocmd('FileType', {
            pattern = langs,
            callback = function()
                vim.treesitter.start()
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        });
    end,
    -- opts = {
    --     ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "rust", "javascript", "typescript", "java" },
    --     sync_install = false,
    --     auto_install = true,
    --     highlight = {
    --         enable = true,
    --         additional_vim_regex_highlighting = false,
    --     },
    -- },
}
