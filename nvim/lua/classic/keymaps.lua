vim.g.mapleader=" "
vim.keymap.set("n", "<leader>ee", vim.cmd.Ex)

-- delete the content in the line, send the content to the blackhole register instead of vimclip, then paste the content of the vimclipboard
vim.keymap.set("x", "<leader>p", [["_dP]])
-- Copy to clipboard Selected & Block/line
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- delete to blackhole
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
-- avoid Vim most danger place
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
-- fast buffer scoped replacement of the focused word 
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- wrap the focus word with "
vim.keymap.set("n", "<leader>\"", [["bciw""<ESC>h"bp]])

