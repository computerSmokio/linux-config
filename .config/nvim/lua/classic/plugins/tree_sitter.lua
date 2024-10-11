return {
    "nvim-treesitter/nvim-treesitter",
    config = function ()
	local config = require("nvim-treesitter.configs")

	config.setup({
		sync_install=false,
		auto_install = true,
		highlight = {
			enable=true,
			additional_vim_regex_highlighting = false,
		}
	})
    end, 
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,
}

