-- Mason
vim.pack.add({
    "g:mason-org/mason.nvim",
    "g:neovim/nvim-lspconfig",
    "g:mason-org/mason-lspconfig.nvim",
})

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "rust_analyzer", "tombi", "clangd" }
})

-- cmp
vim.pack.add({
    "g:hrsh7th/nvim-cmp",
    "g:hrsh7th/cmp-nvim-lsp",
    "g:hrsh7th/cmp-buffer",
    "g:hrsh7th/cmp-path",
    "g:hrsh7th/cmp-calc",
    "g:hrsh7th/cmp-cmdline",
    "g:L3MON4D3/LuaSnip",
    "g:saadparwaiz1/cmp_luasnip",
})

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
    view = {
        entries = "custom"
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'lazydev' },
        { name = 'calc' },
        { name = 'path' },
        { name = 'buffer' },
    }),
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select, count = 1 }),
        ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select, count = 1 }),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-u>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
})

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        {
            name = 'cmdline',
            option = {
                ignore_cmds = { 'Man', '!' }
            }
        }
    })
})

-- luasnip
vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    end
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-j>", function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
    luasnip.jump(-1)
end, { silent = true })
vim.keymap.set("i", "<C-h>", function()
    if luasnip.choice_active() then
        luasnip.change_choice(1)
    end
end, { silent = true })
