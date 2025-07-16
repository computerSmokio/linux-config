
vim.keymap.set("n", "<leader>gs", vim.cmd.Neogit)

require("neogit").setup({})
require("gitsigns").setup({})

vim.keymap.set("v", "<leader>hs", function()
    vim.cmd("Gitsigns stage_hunk")
end, { desc = "Neogit stage hunk" })
