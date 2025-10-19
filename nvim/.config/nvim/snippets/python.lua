require("luasnip.session.snippet_collection").clear_snippets "python"
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


local docstring_args_mapper = function(args)
    return {

    }
end

local docstring_handlers = {
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

local docstring_query_name = "val_actions"

local docstring_node_index = {
    function_definition = 1,
}

local val_query_gen = utils.treesitter_query("helm", docstring_query_name)
local dyn_val = utils.dyn_ret_val(docstring_node_index, val_query_gen, docstring_handlers, docstring_args_mapper, t, sn,
    1)

-- corrected snippet for LuaSnip
ls.add_snippets("python", {
  s("def", fmta([[
  def <name>(<args>)<dyn_ret>
  """
  <init_des>

  args:
    <dyn_doc_args>
  ret:
    <dyn_doc_ret>
  """
  <finish>
  ]], {
    name = i(1),

    args = c(2, {
      i(1),
      sn(nil, { t("self, "), i(1) }),
    }),

    dyn_ret = c(3, {
      t(":"),
      sn(nil, { t(" -> "), i(1), t(":") }),
    }),

    init_des = i(4),

    dyn_doc_args = rep(2),
    dyn_doc_ret = rep(3),
    finish = i(0)
  })),
})
