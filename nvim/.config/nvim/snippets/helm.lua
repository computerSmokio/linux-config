require("luasnip.session.snippet_collection").clear_snippets "helm"
local utils = require("snippetUtils")

local ls = require("luasnip")
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local s = ls.snippet
local c = ls.choice_node
local d = ls.dynamic_node
local i = ls.insert_node
local t = ls.text_node
local sn = ls.snippet_node

local val_args_mapper = function(args)
    return {}
end

local val_handlers = {
    range_variable_definition = function(node, info)
        -- index - element
        local index = node:field("index")[1]
        local index_name = vim.treesitter.get_node_text(index:field("name")[1], 0)
        local elem = node:field("element")[1]
        local elem_name = vim.treesitter.get_node_text(elem:field("name")[1], 0)
        return {
            c(info.index, {
                t("$" .. index_name),
                t("$" .. elem_name),
                t("$.Values"),
                t("$.Chart")
            })
        }
    end,
    variable_definition = function(node, info)
        -- variable
        local variable_table = node:field('variable')[1]
        local text = vim.treesitter.get_node_text(variable_table:field('name')[1], 0)
        print(text)
        return {
            c(info.index, {
                t("$" .. text),
                t("$.Values"),
                t("$.Chart")
            })
        }
    end,
    with_action = function(node, info)
        return {
            c(info.index, {
                t(""),
                t("$.Values"),
                t("$.Chart")
            })
        }
    end,
    -- text = function(node, info)
    --     return {
    --     }
    -- end
    _default = function(node, info)
        return {
            c(info.index, {
                t(".Values"),
                t(".Chart")
            })
        }
    end,
}

local val_query_name = "val_actions"

local val_node_index = {
    range_action = 1,
    with_action = 0,
}

local val_query_gen = utils.treesitter_query("helm", val_query_name)
local dyn_val = utils.dyn_ret_val(val_node_index, val_query_gen, val_handlers, val_args_mapper, t, sn, 1)

ls.add_snippets("helm", {
    s("val", fmta(
        [[
    {{ <din>.<elem> }}
    <finish>
        ]],
        {
            din = d(1, dyn_val, {}),
            elem = i(2),
            finish = i(0)
        })
    ),
}
)

ls.add_snippets("helm", {
    s("fun", fmta(
        [[
    {{- <func> <key>.<val> }}
        <content>
    {{- end }}
    <finish>
        ]],
        {
            key = d(2, dyn_val, {}),
            func = c(1, {
                t("with "),
                t("range"),
                t("range $key, $val :="),
                t("range $key :="),
            } ),
            val = i(3),
            content = i(4),
            finish = i(0)
        })
    ),
}
)
