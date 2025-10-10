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
  end,
}
