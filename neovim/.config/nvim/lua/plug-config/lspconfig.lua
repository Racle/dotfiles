require("mason").setup()

local mason_lspconfig = require "mason-lspconfig"

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- helper functions

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

local on_attach = function(_, bufnr)
  print()
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, {buffer = bufnr, desc = desc})
  end

  nmap("<leader>lr", vim.lsp.buf.rename, "[R]ename")
  nmap("<leader>la", vim.lsp.buf.code_action, "Code [A]ction")

  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("<leader>lD", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("<leader>lds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>lws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  -- See `:help K` for why this keymap
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("gh", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>lwa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>lwr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap(
    "<leader>wl",
    function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end,
    "[W]orkspace [L]ist Folders"
  )

  -- custom golang
  if vim.bo.filetype == "go" then
    nmap("gr", ":GoReferrers<CR>", "[G]oto [R]Eferences")
    nmap("gd", ":GoDef<CR>", "[G]oto [D]efinition")

    -- debug bindings
    vim.keymap.set("n", "<leader>dd", ":GoDebugStart<CR>", {desc = "GoDebugStart"})
    vim.keymap.set("n", "<leader>dj", ":GoDebugStep<CR>", {desc = "GoDebugStep"})
    vim.keymap.set("n", "<leader>dl", ":GoDebugStepOut<CR>", {desc = "GoDebugStepOut"})
    vim.keymap.set("n", "<leader>dbp", ":GoDebugBreakpoint<CR>", {desc = "GoDebugBreakpoint"})
    vim.keymap.set("n", "<leader>dr", ":GoDebugRestart<CR>", {desc = "GoDebugRestart"})
    vim.keymap.set("n", "<leader>d_", ":GoDebugStop<CR>", {desc = "GoDebugStop"})
  end

  -- custom js
  if vim.bo.filetype == "javascript" then
    nmap("<leader>lo", ":OrganizeImport<CR>", "Organize imports")
  end

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(
    bufnr,
    "Format",
    function(_)
      vim.lsp.buf.format()
    end,
    {desc = "Format current buffer with LSP"}
  )
end

-- setup

local signs = {Error = "✘ ", Warn = " ", Hint = " ", Info = " "}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end

local servers = {
  -- clangd = {},
  gopls = {},
  -- rust_analyzer = {},
  tsserver = {
    commands = {
      OrganizeImports = {
        organize_imports,
        description = "Organize Imports"
      }
    }
  },
  intelephense = {}, -- licence in ~/intelephense/licence.txt
  jsonls = {},
  cssls = {},
  html = {},
  dockerls = {},
  yamlls = {},
  pyright = {},
  csharp_ls = {},
  bashls = {},
  ansiblels = {},
  diagnosticls = {},
  marksman = {},
  sumneko_lua = {
    settings = {
      Lua = {
        workspace = {checkThirdParty = false},
        telemetry = {enable = false},
        diagnostics = {
          globals = {"vim"}
        }
      }
    }
  }
}

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers)
}
mason_lspconfig.setup_handlers {
  function(server_name)
    local settings = {}
    local commands = {}
    if servers[server_name] ~= nil then
      settings = servers[server_name]["settings"]
      commands = servers[server_name]["commands"]
    end
    require("lspconfig")[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = settings,
      commands = commands
    }
  end
}

require("fidget").setup()
