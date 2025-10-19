local M = {}

function M.extend_table(t1, t2)
    local res = {}
    for k, v in pairs(t1) do
        res[k] = v
    end
    for k, v in pairs(t2) do
        res[k] = v
    end
    return res
end

function M.treesitter_query(language, query_name)
    return function()
        return assert(vim.treesitter.query.get(language, query_name), "NO query")
    end
end

function M.dyn_ret_val(base_node_index, query_generator, handlers, args_mapper, t, sn, index)
    local base_res_types = function(info)
        local node = vim.treesitter.get_node()
        while node ~= nil do
            if base_node_index[node:type()] == 1 then
                break
            elseif base_node_index[node:type()] == 0 then
                return handlers[node:type()](node, info)
            end
            node = node:parent()
        end

        if not node then
            vim.notify("Could not find base node", vim.log.levels.WARN)
            return handlers["_default"](node, info)
        end

        local query = query_generator()
        print(query:iter_captures(node, 0))
        for _, capture in query:iter_captures(node, 0) do
            vim.notify(capture:type(), vim.log.levels.INFO)
            if handlers[capture:type()] then
                return handlers[capture:type()](capture, info)
            end
        end
    end
    return function(args)
        local args_t = args_mapper(args)
        args_t = M.extend_table({ index = index }, args_t)

        return sn(
            nil,
            base_res_types(args_t)
        )
    end
end

return M
