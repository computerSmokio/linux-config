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
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ap"] = "@parameter.outer",
                            ["ip"] = "@parameter.inner",
                            ["al"] = "@loop.inner",
                            ["il"] = "@loop.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },

                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>c"] = "@parameter.inner"
                        },
                        swap_previous = {
                            ["<leader>C"] = "@parameter.inner"
                        }
                    },

                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["fd"] = "@function.outer"
                        },
                    },
                },

                sync_install = false,
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
