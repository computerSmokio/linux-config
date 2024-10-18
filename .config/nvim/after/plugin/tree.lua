--[[require("nvim-tree").setup({
	sync_root_with_cwd=true,
	reload_on_bufenter=true,
	respect_buf_cwd=true,
    view = {
        side = "right"
    },
	on_attach = function(bufnr)
		local api = require("nvim-tree.api")
  		local function opts(desc)
		    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end
		api.config.mappings.default_on_attach(bufnr)

	end,
})
vim.keymap.set("n", "<leader>E", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "<leader>.", function ()
    local api = require("nvim-tree.api")
    local focus_node = api.tree.get_node_under_cursor()
    api.tree.change_root(focus_node.absolute_path)
end)

]]--
