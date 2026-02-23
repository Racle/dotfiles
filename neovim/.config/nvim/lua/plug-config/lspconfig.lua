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
  local ok_registry, registry = pcall(require, "mason-registry")
  if not ok_registry then
    vim.notify("Mason registry is not available", vim.log.levels.ERROR)
    return
  end

  local package = registry.get_package("sonarlint-language-server")

  if not package:is_installed() then
    vim.notify("Installing SonarLint Language Server via Mason...", vim.log.levels.INFO)
    package:install():once(
      "closed",
      function()
        vim.schedule(
          function()
            vim.notify("SonarLint installed! Restart Neovim to activate.", vim.log.levels.INFO)
          end
        )
      end
    )
    return
  end

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

-- LSP keymaps applied to every buffer when an LSP server attaches
vim.api.nvim_create_autocmd(
  "LspAttach",
  {
    group = vim.api.nvim_create_augroup("UserLspKeymaps", {clear = true}),
    callback = function(args)
      local bufnr = args.buf

      local nmap = function(keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, {buffer = bufnr, desc = desc})
      end

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
      nmap("<leader>lr", vim.lsp.buf.rename, "[R]ename (with lsp)")
      nmap("<leader>la", "<cmd>Lspsaga code_action<CR>", "Code [A]ction")
      -- € = altgr + e
      nmap("[€", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
      nmap("]€", "<cmd>Lspsaga diagnostic_jump_next<CR>")

      -- workspace
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
      if vim.bo[bufnr].filetype == "go" then
        nmap("gr", ":GoReferrers<CR>", "[G]oto [R]Eferences")
        nmap("gd", ":GoDef<CR>", "[G]oto [D]efinition")
        nmap("<leader>lR", ":GoRename<CR>", "Go[R]ename")
      end

      -- custom js
      if vim.bo[bufnr].filetype == "javascript" then
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
  }
)

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
  helm_ls = {
    yamlls = {
      path = "yaml-language-server"
    }
  },
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
  },
  copilot = {}
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

-- apply capabilities to all servers
vim.lsp.config(
  "*",
  {
    capabilities = capabilities
  }
)

-- apply per-server config
for server_name, server_opts in pairs(servers) do
  if next(server_opts) then
    vim.lsp.config(server_name, server_opts)
  end
end

-- enable all servers
vim.lsp.enable(vim.tbl_keys(servers))

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
      vim.diagnostic.enable(false, {bufnr = args.buf})
    end
  }
)
