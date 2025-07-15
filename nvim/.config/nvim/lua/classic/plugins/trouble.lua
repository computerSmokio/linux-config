return {
    {
        "folke/trouble.nvim",
        opts = {},
        cmd = "Trouble",
        keys = {
            { "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Trouble" },
            { "<leader>Tt", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Trouble buffer" },
        },
    },
}
