local lsp_zero = require('lsp-zero')

local lsp_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
end

lsp_zero.extend_lspconfig({
  sign_text = true,
  lsp_attach = lsp_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

local lspkind = require('lspkind')
local cmp = require('cmp')
cmp.setup({
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol",
            max_width = 50,
            symbol_map = { Copilot = "" },
            ellipsis_char = "…",
        }),
    },

    sources = cmp.config.sources({
        {name = "nvim_lsp"},
        {name = "luasnip"},
        {name = "copilot"},
    }, {
        {name = "buffer"},
        {name = "path"},
    }),
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({select = true}),
    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
})

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        {name = 'buffer'},
    },
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        {name = "path"},
    }, {
        name = 'cmdline',
        option = {
            ignore_cmds = { 'Man', '!' },
        },
    }),
})

local lsp_conf = require('lspconfig')
local capabilities = require("cmp_nvim_lsp").default_capabilities()
lsp_conf.pylsp.setup({
    capabilities = capabilities,
    on_attach = lsp_attach,
})

lsp_conf.lua_ls.setup({
    capabilities = capabilities,
    on_attach = lsp_attach,
})
lsp_conf.yamlls.setup({
    capabilities = capabilities,
    on_attach = lsp_attach,
})
lsp_conf.jsonls.setup({
    capabilities = capabilities,
    on_attach = lsp_attach,
})
lsp_conf.yamlls.setup({
    capabilities = capabilities,
    on_attach = lsp_attach,
})
lsp_conf.helm_ls.setup({
    capabilities = capabilities,
    on_attach = lsp_attach,
    settings = {
        ["helm-ls"] = {
            logLevel = "info",
            valuesFiles = {
                mainValuesFile = "values.yaml",
                lintOverlayValuesFile = "values-lint.yaml",
                additionalValuesFilesGlobPattern = "*values*.yaml",
            },
            yamlls = {
                enabled = true,
                enabledForFilesGlob = "*.{yaml,yml}",
                diagnosticsLimit = 50,
                showDiagnosticsDirectly = false,
                path = "yaml-language-server",
                config = {
                    schemas = {
                        kubernetes = "templates/**",
                    },
                    completion = true,
                    hover = true,
                }
            }
        }
    }
})

lsp_conf.gopls.setup({
    capabilities = capabilities,
    on_attach = lsp_attach,
})

lsp_conf.bashls.setup({
    capabilities = capabilities,
    on_attach = lsp_attach,
})

lsp_conf.terraform_lsp.setup({
    capabilities = capabilities,
    on_attach = lsp_attach,
})

lsp_conf.dockerls.setup({
    capabilities = capabilities,
    on_attach = lsp_attach,
})

