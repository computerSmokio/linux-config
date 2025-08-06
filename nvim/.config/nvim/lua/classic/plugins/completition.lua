return {
    { 'onsails/lspkind.nvim' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    {
        'L3MON4D3/LuaSnip',
        dependencies = {
            { 'rafamadriz/friendly-snippets' },
            { 'saadparwaiz1/cmp_luasnip' },
        }
    },
    { 'hrsh7th/nvim-cmp' },
    {
        "zbirenbaum/copilot-cmp",
        config = function()
            require("copilot_cmp").setup()
        end
    }


}
