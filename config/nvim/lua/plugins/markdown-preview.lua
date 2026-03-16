return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
        vim.g.mkdp_filetypes = { "markdown" }
        vim.g.mkdp_browser = "/usr/bin/firefox"
        vim.g.mkdp_port = '8894'
    end,
    ft = { "markdown" },
}
