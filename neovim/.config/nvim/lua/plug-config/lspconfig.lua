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

      local map = function(mode, keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end
        vim.keymap.set(mode, keys, func, {buffer = bufnr, desc = desc})
      end

      local nmap = function(keys, func, desc)
        map("n", keys, func, desc)
      end

      -- navigation
      nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
      nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
      nmap("gD", require("telescope.builtin").lsp_definitions, "Peek [D]efinition")
      nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
      nmap("gh", vim.lsp.buf.hover, "[H]over documentation")
      nmap("gK", vim.lsp.buf.signature_help, "Signature Help")
      map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature Help")

      -- <leader>l LSP
      nmap("<leader>lr", vim.lsp.buf.rename, "[R]ename")
      map({"n", "x"}, "<leader>la", vim.lsp.buf.code_action, "Code [A]ction")
      nmap("<leader>lD", vim.lsp.buf.type_definition, "Type [D]efinition")
      nmap("<leader>lds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
      nmap("<leader>lws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
      map({"n", "x"}, "<leader>ll", vim.lsp.codelens.run, "Run Code[l]ens")
      nmap("<leader>lL", vim.lsp.codelens.refresh, "Refresh Code[L]ens")
      nmap(
        "<leader>lA",
        function()
          vim.lsp.buf.code_action({context = {only = {"source"}, diagnostics = {}}})
        end,
        "Source [A]ction"
      )
      nmap("<leader>li", "<cmd>LspInfo<CR>", "LSP [I]nfo")
      nmap(
        "<leader>lF",
        function()
          Snacks.rename.rename_file()
        end,
        "Rename [F]ile"
      )

      -- diagnostics (€ = altgr + e)
      nmap(
        "[€",
        function()
          vim.diagnostic.jump({count = -1})
        end,
        "Prev diagnostic"
      )
      nmap(
        "]€",
        function()
          vim.diagnostic.jump({count = 1})
        end,
        "Next diagnostic"
      )

      -- reference navigation (only active when LSP references are highlighted)
      nmap(
        "]]",
        function()
          if Snacks.words.is_enabled() then
            Snacks.words.jump(vim.v.count1)
          else
            -- fallback to default ]] behavior
            vim.cmd("normal! ]]")
          end
        end,
        "Next Reference"
      )
      nmap(
        "[[",
        function()
          if Snacks.words.is_enabled() then
            Snacks.words.jump(-vim.v.count1)
          else
            -- fallback to default [[ behavior
            vim.cmd("normal! [[")
          end
        end,
        "Prev Reference"
      )

      -- workspace
      nmap("<leader>lwa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
      nmap("<leader>lwr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
      nmap(
        "<leader>lwl",
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
        nmap("<leader>lI", ":ImportMissing<CR>", "Import missing")
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
