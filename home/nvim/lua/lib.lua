local M = {}

function M.parse_opts(value)
  local kind = type(value)

  if kind == "table" then
    return function() 
      return value
    end
  end

  if kind == "function" then
    return value
  end

  return function()
    --
  end
end

function M.parse_keys(value)
  local kind = type(value)

  if kind == "table" then
    return function()
      return value
    end
  end

  if kind == "function" then
    return value
  end

  return function()
    --
  end
end

return M
