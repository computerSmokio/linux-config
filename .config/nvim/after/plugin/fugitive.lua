vim.keymap.set("n", "<leader>gs", vim.cmd.Neogit)

require("neogit").setup({})
require("gitsigns").setup({})
