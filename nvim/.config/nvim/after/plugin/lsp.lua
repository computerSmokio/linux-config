local opts = { noremap = true, silent = true, buffer = bufnr }
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
vim.keymap.set('n', '<F1>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
vim.keymap.set({ 'n', 'x' }, '<F2>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
vim.keymap.set('n', '<F3>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))
capabilities = vim.tbl_deep_extend('force', capabilities, {
    textDocument = {
        foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }
    }
})

local lsp_conf = require('lspconfig')

vim.lsp.enable('zls', {
    capabilities = capabilities,
})
vim.lsp.enable("ts_ls", {
    capabilities = capabilities,
})
vim.lsp.enable('rust_analyzer', {
    capabilities = capabilities,
})
vim.lsp.enable('pylsp', {
    capabilities = capabilities,
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = { "E501", "E203", "E266", "E402", "E722", "W503", "W504" },
                },
            },
        },
    }
})
vim.lsp.enable('lua_ls', {
    capabilities = capabilities,
})
vim.lsp.enable('yamlls', {
    capabilities = capabilities,
})
vim.lsp.enable('helm_ls', {
    capabilities = capabilities,
    settings = {
        ['helm-ls'] = {
            logLevel = "info",
            valuesFiles = {
                mainValuesFile = "values.yaml",
                lintOverlayValuesFile = "values.lint.yaml",
                additionalValuesFilesGlobPattern = "values*.yaml"
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
                    -- any other config from https://github.com/redhat-developer/yaml-language-server#language-server-settings
                }
            }
        }
    }
})
vim.lsp.enable('gopls', {
    capabilities = capabilities,
})
vim.lsp.enable('terraformls', {
    capabilities = capabilities,
})
vim.lsp.enable('dockerls', {
    capabilities = capabilities,
})
vim.lsp.enable('bashls', {
    capabilities = capabilities,
})
vim.lsp.enable('jsonls', {
    capabilities = capabilities,
})
vim.lsp.enable('qmlls', {
    cmd = "qmlls6",
    capabilities = capabilities,
})

vim.lsp.enable('groovyls', {
    cmd = { "java", "-jar", "/Users/matvargas/code/groovyls/groovy-language-server-master-all.jar" },
})
