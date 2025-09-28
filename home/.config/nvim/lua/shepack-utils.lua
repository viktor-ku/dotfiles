local plugins = {}

local join = vim.fs.joinpath
local std_config = vim.fn.stdpath("config")
local stat = vim.uv.fs_stat

local function spec(opts)
  plugins[#plugins + 1] = opts
end

local function spec_one(name)
  local ok, config = pcall(require, join("shepack", name))

  if not ok then
    local filepath = join(std_config, "lua", "shepack", name .. ".lua")

    if stat(filepath) then
      -- so we just failed to load up, but the file exists, ok
      return
    end

    local fd = io.open(filepath, "w")

    if fd then
      fd:write(
        "-- Specify your plugin according to this spec:\n",
        "-- https://github.com/lewis6991/pckr.nvim?tab=readme-ov-file#specifying-plugins\n",
        "return {\n",
        '  "",\n',
        '  commit = "",\n',
        "  config = function()\n",
        "    -- script after plugin is loaded\n",
        "  end,\n",
        "}\n"
      )

      fd:close()
    else
      error("Could not write into an empty file: " .. filepath)
    end

    return
  end

  local probe = config[1]

  if type(probe) == "string" then
    if #probe >= 3 then
      plugins[#plugins + 1] = config
    end
  else
    error("shepack/" .. name .. ": expected a flat plugin, not a " .. type(probe))
  end
end

local function spec_mod(name)
  local ok, config = pcall(require, join("shepack", name))

  if not ok then
    local dirpath = join(std_config, "lua", "shepack", name)
    local filepath = join(dirpath, "init.lua")

    local dirpath_stat = stat(dirpath)

    if dirpath_stat then
      if dirpath_stat.type ~= "directory" then
        error(dirpath .. " is expected to be a directory")
      end
    else
      local mkdir_ok, _ = pcall(vim.fn.mkdir, dirpath, "p")

      if not mkdir_ok then
        error("Could not mkdir -p " .. dirpath)
      end
    end

    local filepath_stat = stat(filepath)

    if filepath_stat then
      error(filepath .. " exists, but could not be loaded as a plugin: " .. config)
    end

    local fd = io.open(filepath, "w")

    if fd then
      fd:write(
        "-- Specify your list of plugins, each of them according to this spec:\n",
        "-- https://github.com/lewis6991/pckr.nvim?tab=readme-ov-file#specifying-plugins\n",
        "return {\n",
        "  {\n",
        '    "",\n',
        '    commit = "",\n',
        "    config = function()\n",
        "      -- script after plugin is loaded\n",
        "    end,\n",
        "  },\n",
        "}\n"
      )

      fd:close()
    else
      error("Could not write to an empty file: " .. filepath)
    end

    return
  end

  if vim.islist(config) then
    for _, it in ipairs(config) do
      plugins[#plugins + 1] = it
    end
  else
    error(join("shepack", name, "init.lua") .. " expected a list, got " .. type(config))
  end
end

return {
  _ = spec,
  one = spec_one,
  mod = spec_mod,
  plugins = function()
    return plugins
  end,
}
