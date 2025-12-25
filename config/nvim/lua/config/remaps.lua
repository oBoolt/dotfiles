vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Moves the lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "]]", "]]zt")
vim.keymap.set("n", "[[", "[[zt")

-- Copy and Paste
vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y")
vim.keymap.set({ "n", "v" }, "<leader>Y", "\"+Y")
vim.keymap.set("n", "<leader>p", "\"+p")

-- Deletion
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

-- Misc
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Move windows
vim.keymap.set({ 'n', 't' }, '<C-h>', '<CMD>NavigatorLeft<CR>')
vim.keymap.set({ 'n', 't' }, '<C-l>', '<CMD>NavigatorRight<CR>')
vim.keymap.set({ 'n', 't' }, '<C-k>', '<CMD>NavigatorUp<CR>')
vim.keymap.set({ 'n', 't' }, '<C-j>', '<CMD>NavigatorDown<CR>')

-- Splitting and Resize
vim.keymap.set("n", "<leader>v", ":vsplit<CR>")
vim.keymap.set("n", "<leader>h", ":split<CR>")
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")


-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP Remaps",
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(event)
        local opts = { buffer = event.buf }
        local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

        opts.desc = "Rename variable"
        vim.keymap.set("n", "grn", function() vim.lsp.buf.rename() end, opts)

        opts.desc = "Show code actions"
        vim.keymap.set("n", "gra", function() vim.lsp.buf.code_action() end, opts)

        opts.desc = "Show LSP references"
        vim.keymap.set("n", "grr", function() vim.lsp.buf.references() end, opts)

        opts.desc = "Show LSP type definitions"
        vim.keymap.set("n", "grd", function() vim.lsp.buf.definition() end, opts)

        if client:supports_method('textDocument/declaration') then
            opts.desc = "Go to declaration"
            vim.keymap.set("n", "grD", function() vim.lsp.buf.declaration() end, opts)
        end

        if client:supports_method('textDocument/implementation') then
            opts.desc = "Go to implementation"
            vim.keymap.set("n", "gri", function() vim.lsp.buf.implementation() end, opts)
        end

        opts.desc = "Show documentation under the cursor"
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)

        opts.desc = "Show buffer diagnostics"
        vim.keymap.set("n", "gd", function() vim.diagnostic.open_float() end, opts)

        vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

        -- Auto-format ("lint") on save.
        -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
            vim.keymap.set("n", "grf",
                function() vim.lsp.buf.format({ bufnr = event.buf, id = client.id, timeout_ms = 500 }) end, opts)
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
                buffer = event.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = event.buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
    end,
})
