local M = {}

--- @param value table|function|nil
--- @param args function
--- @return function
function M.parse_opts(value, args)
  local kind = type(value)

  if kind == "table" then
    return function()
      return value
    end
  end

  if kind == "function" then
    local ret = value(args())
    if type(ret) == "table" then
      return function()
        return ret
      end
    end
    error("parse_opts(): expected table, got " .. type(ret))
  end

  if kind == "nil" then
    return function()
      return {}
    end
  end

  error("parse_opts: expected table|function|nil, got " .. kind)
end

--- @param value function|nil
--- @return function
function M.parse_config(value)
  local kind = type(value)

  if kind == "function" then
    return value
  end

  if kind == "nil" then
    return function() end
  end

  error("parse_config: expected function|nil, got " .. kind)
end

--- @param value function|nil
--- @return function
function M.parse_keys(value)
  local kind = type(value)

  if kind == "function" then
    return value
  end

  if kind == "nil" then
    return function() end
  end

  error("parse_keys: expected function|nil, got " .. kind)
end

return M
