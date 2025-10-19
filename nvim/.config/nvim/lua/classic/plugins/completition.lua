return {
    { 'onsails/lspkind.nvim' },
    {
        "saghen/blink.cmp",
        version = "1.*",
        event = "InsertEnter",
        lazy = false,
        build = 'cargo build --release',
        dependencies = { { "fang2hou/blink-copilot" },
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                build = "make install_jsregexp"
            } },
        opts = {
            keymap = {
                preset = "none",
                ['<C-n>'] = { 'select_prev', 'fallback' },
                ['<C-i>'] = { 'select_next', 'fallback' },
                ['<C-e>'] = { 'accept', 'fallback' },

            },
            completion = {
                menu = {
                    border = 'single',
                    draw = {
                        columns = { { 'item_idx' }, { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
                        components = {
                            item_idx = {
                                text = function(ctx)
                                    return ctx.idx == 10 and '0' or ctx.idx >= 10 and ' ' or
                                        tostring(ctx.idx)
                                end,
                                highlight = 'BlinkCmpItemIdx' -- optional, only if you want to change its color
                            }
                        }
                    }
                },
                documentation = { window = { border = 'single' } }
            },
            signature = {
                window = { border = 'single' },
            },
            sources = {
                default = { "copilot", "lsp", "path", "snippets", "buffer" },
                providers = {
                    snippets = {
                        name = "snippets",
                        module = "blink.cmp.sources.snippets",
                        enabled = true,
                        min_keyword_length = 2,
                        score_offset = 95,

                    },
                    copilot = {
                        name = "copilot",
                        module = "blink-copilot",
                        score_offset = 60,
                        async = true,
                    },
                },
            },
        },
    }
}
