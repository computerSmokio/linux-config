return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main", 
        lazy = false,
        build = ":TSUpdate",
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })
        end
    },
    { 
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            local textobjects = require("nvim-treesitter-textobjects")
            
            textobjects.setup({
                select = {
                    lookahead = true,
                },
                move = {
                    set_jumps = true,
                },
            })
            local select_maps = {
                ["]f"] = "@function.outer",
                ["[f"] = "@function.inner",
                ["]p"] = "@parameter.outer",
                ["[p"] = "@parameter.inner",
                ["]l"] = "@loop.outer",
                ["[l"] = "@loop.inner",
                ["]c"] = "@class.outer",
                ["[c"] = "@class.inner",
            }
            for k, v in pairs(select_maps) do
                vim.keymap.set({ "n", "x", "o" }, k, function()
                    require("nvim-treesitter-textobjects.select").select_textobject(v, "textobjects")
                end, { desc = "Select " .. v })
            end
            vim.keymap.set({ "n", "x", "o" }, "<leader>cp", function()
                require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
            end, { desc = "Swap parameter next" })
            vim.keymap.set({ "n", "x", "o" }, "<leader>cP", function()
                require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
            end, { desc = "Swap parameter previous" })
            vim.keymap.set({ "n", "x", "o" }, "gf", function()
                require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
            end, { desc = "Goto next function start" })
            vim.keymap.set({ "n", "x", "o" }, "gF", function()
                require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
            end, { desc = "Goto previous function start" })
        end
    },
}
