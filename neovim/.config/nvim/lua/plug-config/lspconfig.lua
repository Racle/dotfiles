local mason_lspconfig = require "mason-lspconfig"

-- install snyk-ls
-- bash  -c "curl https://raw.githubusercontent.com/snyk/snyk-ls/main/getLanguageServer.sh | sudo bash -"

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

local function import_missing()
  local params = {
    command = "TypescriptAddMissingImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

-- enable sonarlint support
local function enable_sonarlint()
  require("sonarlint").setup(
    {
      server = {
        cmd = {
          "sonarlint-language-server",
          -- Ensure that sonarlint-language-server uses stdio channel
          "-stdio",
          "-analyzers",
          -- paths to the analyzers you need, using those for python and java in this example
          vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
          vim.fn.expand("$MASON/share/sonarlint-analyzers/sonargo.jar"),
          vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarhtml.jar"),
          vim.fn.expand("$MASON/share/sonarlint-analyzers/sonariac.jar"),
          vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
          vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
          vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarphp.jar"),
          vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
          vim.fn.expand("$MASON/share/sonarlint-analyzers/sonartext.jar"),
          vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarxml.jar")
        }
      },
      filetypes = {
        -- "javascript",
        "php",
        "go",
        "html",
        "css",
        "dockerfile"
      }
    }
  )
end

local on_attach = function(_, bufnr)
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

  -- nmap("<leader>lr", vim.lsp.buf.rename, "[R]ename")
  -- nmap("<leader>la", vim.lsp.buf.code_action, "Code [A]ction")

  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")

  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("<leader>lD", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("<leader>lds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>lws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  -- lspsaga
  nmap("gh", "<cmd>Lspsaga hover_doc<CR>", "[H]over documentation")
  nmap("gD", "<cmd>Lspsaga peek_definition<CR>", "Peek [D]efinition")
  nmap("<leader>lf", "<cmd>Lspsaga lsp_finder<CR>", "[F]ind lsp")
  -- nmap("<leader>lr", "<cmd>Lspsaga rename ++project<CR>", "[R]ename")
  nmap("<leader>lr", vim.lsp.buf.rename, "[R]ename (with lsp)")
  nmap("<leader>la", "<cmd>Lspsaga code_action<CR>", "Code [A]ction")
  -- € = altgr + e
  nmap("[€", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
  nmap("]€", "<cmd>Lspsaga diagnostic_jump_next<CR>")

  -- See `:help K` for why this keymap
  -- nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  -- nmap("gh", vim.lsp.buf.hover, "Hover Documentation")
  -- nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  -- nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
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
    nmap("<leader>lR", ":GoRename<CR>", "Go[R]ename")
  end

  -- custom js
  if vim.bo.filetype == "javascript" then
    nmap("<leader>lo", ":OrganizeImport<CR>", "Organize imports")
    nmap("<leader>li", ":ImportMissing<CR>", "Import missing")
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
  gopls = {cmd = {"gopls", "--remote=auto"}},
  -- rust_analyzer = {},
  ts_ls = {
    commands = {
      OrganizeImports = {
        organize_imports,
        description = "Organize Imports"
      },
      ImportMissing = {
        import_missing,
        description = "Import missing"
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
  terraformls = {},
  helm_ls = {},
  lua_ls = {
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
  -- TODO add back when sonarlint is added to mason-lspconfig
  -- ["sonarlint-language-server"] = {}
}

require("mason").setup()
mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers)
}

-- TODO disable this when sonarlint is added to mason-lspconfig
-- :MasonInstall sonarlint-language-server
enable_sonarlint()

mason_lspconfig.setup_handlers {
  function(server_name)
    -- TODO check if we need this when sonarlint is added to mason-lspconfig
    -- if server_name == "sonarlint-language-server" then
    --   enable_sonarlint()
    --   return
    -- end

    local settings = {}
    local commands = {}
    local cmd = {}
    if servers[server_name] ~= nil then
      settings = servers[server_name]["settings"]
      commands = servers[server_name]["commands"]
      cmd = servers[server_name]["cmd"]
    end
    local opts = {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = settings,
      commands = commands,
      cmd = cmd
    }

    if server_name == "tsserver" then
      require("typescript").setup {server = opts}
    else
      require("lspconfig")[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = settings,
        commands = commands,
        cmd = cmd
      }
    end
  end
}
require("lspconfig").helm_ls.setup {
  settings = {
    ["helm-ls"] = {
      yamlls = {
        path = "yaml-language-server"
      }
    }
  }
}

require("fidget").setup()

-- autocmd to setup filetype
vim.cmd [[autocmd BufNewFile,BufRead *.ans.yml set ft=yaml.ansible]]

-- disable lsp for .env files
local group = vim.api.nvim_create_augroup("__env", {clear = true})
vim.api.nvim_create_autocmd(
  "BufEnter",
  {
    pattern = {"*.env", ".env*"},
    group = group,
    callback = function(args)
      vim.cmd [[set filetype=sh]] -- set ft to sh to enable syntax highlighting
      vim.diagnostic.disable(args.buf) --disable for this buffer
    end
  }
)
