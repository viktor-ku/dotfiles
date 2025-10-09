local function jump_to_location(loc, encoding)
  local uri = loc.uri or loc.targetUri
  if not uri then
    return
  end
  local fname = vim.uri_to_fname(uri)
  local rng = loc.range or loc.targetSelectionRange or loc.selectionRange
  if not rng then
    -- just open the file if range is missing
    vim.cmd("edit " .. vim.fn.fnameescape(fname))
    return
  end

  vim.cmd("edit " .. vim.fn.fnameescape(fname))
  local bufnr = vim.api.nvim_get_current_buf()

  -- Neovim expects a *byte* column; convert from LSP position
  local row = (rng.start.line or 0)
  local col = vim.lsp.util._get_line_byte_from_position(bufnr, rng.start, encoding or "utf-16")
  vim.api.nvim_win_set_cursor(0, { row + 1, col })
end

local function reload_workspace(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "rust_analyzer" })
  for _, client in ipairs(clients) do
    vim.notify("Reloading Cargo Workspace")
    ---@diagnostic disable-next-line:param-type-mismatch
    client:request("rust-analyzer/reloadWorkspace", nil, function(err)
      if err then
        error(tostring(err))
      end
      vim.notify("Cargo workspace reloaded")
    end, 0)
  end
end

local function is_library(fname)
  local user_home = vim.fs.normalize(vim.env.HOME)
  local cargo_home = os.getenv("CARGO_HOME") or user_home .. "/.cargo"
  local registry = cargo_home .. "/registry/src"
  local git_registry = cargo_home .. "/git/checkouts"

  local rustup_home = os.getenv("RUSTUP_HOME") or user_home .. "/.rustup"
  local toolchains = rustup_home .. "/toolchains"

  for _, item in ipairs({ toolchains, registry, git_registry }) do
    if vim.fs.relpath(item, fname) then
      local clients = vim.lsp.get_clients({ name = "rust_analyzer" })
      return #clients > 0 and clients[#clients].config.root_dir or nil
    end
  end
end

---@type vim.lsp.Config
return {
  cmd = { "rustup", "run", "nightly", "rust-analyzer" },
  filetypes = { "rust" },
  settings = {
    ["rust-analyzer"] = {
      inlayHints = {
        enable = true,
        chainingHints = true,
        parameterHints = true,
        typeHints = true,
        hideNamedConstructorHints = false,
        maxLength = 32, -- keep lines readable
      },
      lens = {
        enable = true,
        methodReferences = true,
        references = true,
      },
      hover = {
        actions = {
          enable = true,
        },
      },
      completion = {
        callable = { snippets = "add_parentheses" },
        autoself = { enable = true },
        postfix = { enable = true },
      },
      imports = {
        granularity = { group = "module" }, -- fewer, cleaner lines
        prefix = "crate", -- or "self" if you prefer
      },
      assist = {
        importEnforceGranularity = true,
        importPrefix = "crate",
      },
      diagnostics = {
        enable = true,
        -- Commonly suppressed when proc-macros get spicy:
        disabled = { "unresolved-proc-macro" },
        experimental = { enable = true },
      },
      files = {
        -- Avoid file watcher limits on Linux/WSL; lets Neovim drive watching
        watcher = "client",
        -- Exclude giant dirs to keep RA snappy, e.g.:
        excludeDirs = { ".direnv", ".git", "target", "node_modules", "~/.cargo" },
      },
    },
  },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local reused_dir = is_library(fname)
    if reused_dir then
      on_dir(reused_dir)
      return
    end

    local cargo_crate_dir = vim.fs.root(fname, { "Cargo.toml" })
    local cargo_workspace_root

    if cargo_crate_dir == nil then
      on_dir(
        vim.fs.root(fname, { "rust-project.json" })
          or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
      )
      return
    end

    local cmd = {
      "cargo",
      "metadata",
      "--no-deps",
      "--format-version",
      "1",
      "--manifest-path",
      cargo_crate_dir .. "/Cargo.toml",
    }

    vim.system(cmd, { text = true }, function(output)
      if output.code == 0 then
        if output.stdout then
          local result = vim.json.decode(output.stdout)
          if result["workspace_root"] then
            cargo_workspace_root = vim.fs.normalize(result["workspace_root"])
          end
        end

        on_dir(cargo_workspace_root or cargo_crate_dir)
      else
        vim.schedule(function()
          vim.notify(("[rust_analyzer] cmd failed with code %d: %s\n%s"):format(output.code, cmd, output.stderr))
        end)
      end
    end)
  end,
  capabilities = {
    experimental = {},
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
          commitCharactersSupport = true,
          deprecatedSupport = true,
          preselectSupport = true,
          insertReplaceSupport = true,
          tagSupport = { valueSet = { 1 } }, -- {1}=Deprecated tag
          resolveSupport = { -- let server lazily add details/edits
            properties = { "documentation", "detail", "additionalTextEdits" },
          },
          documentationFormat = { "markdown", "plaintext" },
          labelDetailsSupport = true, -- richer labels (e.g., module paths)
        },
      },
      signatureHelp = {
        signatureInformation = {
          documentationFormat = { "markdown", "plaintext" },
          parameterInformation = { labelOffsetSupport = true },
        },
      },
      hover = {
        contentFormat = { "markdown", "plaintext" },
      },
      codeAction = {
        dynamicRegistration = false,
        codeActionLiteralSupport = {
          codeActionKind = {
            valueSet = {
              "quickfix",
              "refactor",
              "refactor.extract",
              "refactor.inline",
              "refactor.rewrite",
              "source",
              "source.organizeImports",
              "source.fixAll",
            },
          },
        },
        dataSupport = true,
        isPreferredSupport = true,
      },
      codeLens = {
        dynamicRegistration = true,
      },
      semanticTokens = {
        -- Ask for both range+full; RA will choose what it supports
        requests = { range = true, full = true },
        multilineTokenSupport = true,
        overlappingTokenSupport = true,
      },
      inlayHint = {
        dynamicRegistration = false, -- Neovim 0.10+ uses native inlay hints
      },
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true, -- faster & avoids character-based folding bugs
      },
      publishDiagnostics = {
        relatedInformation = true,
        -- Enable UI tags like “deprecated” and “unnecessary”
        tagSupport = { valueSet = { 1, 2 } }, -- {1}=Unnecessary, {2}=Deprecated
      },
    },
    workspace = {
      configuration = true, -- allow per-workspace rust-analyzer settings
      didChangeWatchedFiles = { dynamicRegistration = true },
      symbol = { resolveSupport = { properties = { "location", "range" } } },
    },
  },
  before_init = function(init_params, config)
    -- See https://github.com/rust-lang/rust-analyzer/blob/eb5da56d839ae0a9e9f50774fa3eb78eb0964550/docs/dev/lsp-extensions.md?plain=1#L26
    if config.settings and config.settings["rust-analyzer"] then
      init_params.initializationOptions = config.settings["rust-analyzer"]
    end
  end,
  on_attach = function(client, bufnr)
    local aug = vim.api.nvim_create_augroup("RustAutocmds", { clear = true })

    vim.api.nvim_buf_create_user_command(bufnr, "LspCargoReload", function()
      reload_workspace(bufnr)
    end, { desc = "Reload current cargo workspace" })

    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

      vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "CursorHold" }, {
        group = aug,
        buffer = bufnr,
        callback = function()
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end,
      })
    end

    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      group = aug,
      pattern = "*.rs",
      callback = function()
        if vim.lsp.codelens and vim.lsp.codelens.refresh then
          pcall(vim.lsp.codelens.refresh)
        end
      end,
    })

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = aug,
      pattern = "*.rs",
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = aug,
      pattern = "*.rs",
      callback = vim.lsp.buf.clear_references,
    })

    vim.api.nvim_create_autocmd("BufWritePost", {
      group = aug,
      pattern = "Cargo.toml",
      callback = function()
        for _, client in ipairs(vim.lsp.get_active_clients({ name = "rust-analyzer" })) do
          client.notify("workspace/didChangeConfiguration", {})
        end
      end,
    })

    local function norm(p)
      return (p or ""):gsub("\\", "/")
    end

    local function is_junk(path)
      path = norm(path)
      return path:find("/target/", 1, true)
        or path:find("/%.cargo/registry/", 1, true)
        or path:find("/%.cargo/git/checkouts/", 1, true)
        or path:find("/%.rustup/toolchains/", 1, true)
        or path:find("/rustc/%x+/", 1) -- e.g. /rustc/abcd1234/
        or path:find("/rust/library/", 1, true) -- std/core/alloc sources
    end

    local function goto_definition_local_first()
      local params = vim.lsp.util.make_position_params(0, "utf-16")

      vim.lsp.buf_request(bufnr, "textDocument/definition", params, function(err, result, ctx, _)
        if err or not result then
          return vim.notify("LSP: no definition", vim.log.levels.WARN)
        end
        local res = result
        if not vim.islist(res) then
          res = { res }
        end

        local root = ""
        local c = vim.lsp.get_client_by_id(ctx.client_id)
        if c and c.config and c.config.root_dir then
          root = norm(c.config.root_dir)
        end

        local function to_path(loc)
          local uri = loc.uri or loc.targetUri
          return uri and norm(vim.uri_to_fname(uri)) or ""
        end

        -- partition: local (inside root & not junk) vs others
        local local_defs, others = {}, {}
        for _, loc in ipairs(res) do
          local p = to_path(loc)
          if p ~= "" and not is_junk(p) and (root ~= "" and p:find(root, 1, true) == 1) then
            table.insert(local_defs, loc)
          else
            table.insert(others, loc)
          end
        end

        local choice = (#local_defs > 0) and local_defs or res

        -- prefer .../src/** inside the chosen set
        table.sort(choice, function(a, b)
          local pa, pb = to_path(a), to_path(b)
          local sa = (pa:find("/src/", 1, true) and 1 or 0)
          local sb = (pb:find("/src/", 1, true) and 1 or 0)
          if sa ~= sb then
            return sa > sb
          end
          return #pa < #pb
        end)

        -- jump straight to the best match
        return jump_to_location(choice[1], "utf-16")
      end)
    end

    vim.keymap.set(
      "n",
      "gd",
      goto_definition_local_first,
      { buffer = bufnr, silent = true, desc = "Go to definition (local-first)" }
    )
  end,
}
