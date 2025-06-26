return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    lazy = false,
    dependencies = {
        {'neovim/nvim-lspconfig'},
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-buffer'},
        {'L3MON4D3/LuaSnip'},
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'}
    },
    init = function()
        vim.opt.signcolumn = 'yes'
    end,
    config = function()
        local lsp_zero = require('lsp-zero')
        local lsp_defaults = require('lspconfig').util.default_config
        lsp_defaults.capabilities = vim.tbl_deep_extend(
            'force',
            lsp_defaults.capabilities,
            require('cmp_nvim_lsp').default_capabilities()
        )

        lsp_zero.format_on_save({
            format_opts = {
                async = false,
                timeout_ms = 10000,
            },
            servers = {
                ['rust_analyzer'] = { 'rust' },
                ['biome'] = { 'javascript', 'typescript', 'json' },
                ['java_language_server'] = { 'java' },
                ['clangd'] = { 'c', 'cpp'}, 
            },
        })

        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                local opts = {buffer = event.buf }

                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

                local id = vim.tbl_get(event, 'data', 'client_id')
                local client = id and vim.lsp.get_client_by_id(id)
                if client == nil then
                    return
                end

                if client.supports_method('textDocument/formatting') then
                    lsp_zero.buffer_autoformat()
                end
            end,
        })


        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = { "rust_analyzer", "clangd", "biome", "emmet_language_server", "java_language_server", "cssls", "tombi" },
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup({})
                end,
            },
        })

        local cmp = require('cmp')
        local cmp_action = require('lsp-zero').cmp_action()

        cmp.setup({
            sources = {
                { name = 'nvim_lsp'},
                { name = 'buffer' },
            },
            snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select, count = 1 }),
                ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select, count = 1 }),
                ['<C-Space>'] = cmp.mapping.complete(),
            }),
        })
    end,
}

