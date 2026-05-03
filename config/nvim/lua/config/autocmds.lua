local augroup = vim.api.nvim_create_augroup("my.cmds", {})

-- Create undodir
if vim.fn.isdirectory(vim.g.undodir) == 0 then
    vim.fn.mkdir(vim.g.undodir, "p")
end

-- Set cursor to last line
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local line_count = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= line_count then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    callback = function()
        vim.hl.on_yank()
    end
})

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    group = augroup,
    callback = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        vim.lsp.config("*", {
            capabilities = capabilities
        })
    end
})

vim.api.nvim_create_autocmd("PackChanged", {
    group = augroup,
    callback = function(e)
        local name, kind, active = e.data.spec.name, e.data.kind, e.data.active

        if name == 'nvim-treesitter' and kind == 'update' then
            if not active then vim.cmd.packadd('nvim-treesitter') end
            vim.cmd('TSUpdate')
        end

        if name == 'telescope-fzf-native.nvim' and (kind == 'update' or kind == 'install') then
            vim.system({ 'make' }, { cwd = e.data.path })
        end
    end
})
