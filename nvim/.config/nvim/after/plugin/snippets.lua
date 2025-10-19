local ls = require("luasnip")


require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets" })

vim.keymap.set({"i"}, "<C-k>", function() ls.expand() end, {noremap=true, silent = true})
vim.keymap.set({"i", "s"}, "<C-l>", function() ls.jump( 1) end, {noremap=true, silent = true})
vim.keymap.set({"i", "s"}, "<C-j>", function() ls.jump(-1) end, {noremap=true, silent = true})
vim.keymap.set({"i", "s"}, "<C-u>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {noremap=true, silent = true})
