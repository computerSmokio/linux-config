local hard=require("hardtime")
hard.setup()

vim.api.nvim_set_keymap("n", "<leader>ht", "<cmd>Hardtime toggle<cr>", {noremap = true})
