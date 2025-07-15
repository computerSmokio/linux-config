return {
    { 'VonHeikemen/lsp-zero.nvim', branch = 'v4.x' },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
        "saghen/blink.cmp",
        }
    },
    {
        "saghen/blink.cmp",
        optional = true,
        dependencies = { "fang2hou/blink-copilot" },
        opts = {
            sources = {
                default = { "copilot" },
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
}
