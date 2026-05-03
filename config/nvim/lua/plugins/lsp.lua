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
    "g:hrsh7th/cmp-buffer",
    "g:hrsh7th/cmp-path",
    "g:hrsh7th/cmp-nvim-lsp",
    "g:hrsh7th/cmp-calc",
    "g:saadparwaiz1/cmp_luasnip",
    "g:L3MON4D3/LuaSnip",
})

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "calc" },
    }),
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select, count = 1 }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select, count = 1 }),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
})
