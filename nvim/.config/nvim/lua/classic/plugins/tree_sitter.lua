return {
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            local config = require("nvim-treesitter.configs")

            config.setup({
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["of"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["op"] = "@parameter.outer",
                            ["ip"] = "@parameter.inner",
                            ["ol"] = "@loop.inner",
                            ["il"] = "@loop.inner",
                            ["oc"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },

                    swap = {
                        swap_next = {
                            ["<leader>cp"] = "@parameter.inner"
                        },
                        swap_previous = {
                            ["<leader>cP"] = "@parameter.inner"
                        },
                        enable = true
                    },

                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_previous_start = {
                            ["gF"] = "@function.outer"
                        },
                        goto_next_start = {
                            ["gf"] = "@function.outer"
                        },
                    },
                },

                sync_install = true,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                }
            })
        end,
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })()
        end
    },
    { "nvim-treesitter/nvim-treesitter-textobjects" },
}
