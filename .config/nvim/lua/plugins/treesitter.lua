return {
    'nvim-treesitter/nvim-treesitter',
    main = 'nvim-treesitter.configs',
    opts = {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "rust", "javascript", "typescript" },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
    },
    build = ':TSUpdate',
}
