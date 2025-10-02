return {
    { 'onsails/lspkind.nvim' },
    {
        "saghen/blink.cmp",
        version = "1.*",
        event = "InsertEnter",
        lazy = false,
        build = 'cargo build --release',
        dependencies = { "fang2hou/blink-copilot" },
        opts = {
            completion = {
                menu = {
                    border = 'single',
                    draw = {
                        columns = { { 'item_idx' }, { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
                        components = {
                            item_idx = {
                                text = function(ctx) return ctx.idx == 10 and '0' or ctx.idx >= 10 and ' ' or
                                    tostring(ctx.idx) end,
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
                    copilot = {
                        name = "copilot",
                        module = "blink-copilot",
                        score_offset = 100,
                        async = true,
                    },
                },
            },
        },
    }
    -- {'hrsh7th/cmp-nvim-lsp'},
    -- {'hrsh7th/cmp-buffer'},
    -- {'hrsh7th/cmp-path'},
    -- {'hrsh7th/cmp-cmdline'},
    -- {'L3MON4D3/LuaSnip',
    --     dependencies = {
    --         {'rafamadriz/friendly-snippets'},
    --         {'saadparwaiz1/cmp_luasnip'},
    --     }
    -- },
    -- {'hrsh7th/nvim-cmp'}
}
