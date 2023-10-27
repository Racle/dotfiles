local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system(
    {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath
    }
  )
end
vim.opt.rtp:prepend(lazypath)

-- run :source whenever plugins.lua is updated with
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile>
--   augroup end
-- ]])

local plugins = {
  "Bekaboo/dropbar.nvim",
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- Useful status updates for LSP
      {
        "j-hui/fidget.nvim",
        branch = "legacy"
      },
      -- more typescript commands: https://github.com/jose-elias-alvarez/typescript.nvim
      "jose-elias-alvarez/typescript.nvim",
      -- sonarlint (filetypes are set in lspconfig.lua)
      "https://gitlab.com/schrieveslaach/sonarlint.nvim.git"
    },
    build = "pip install ansible-lint"
  },
  -- better lsp errors
  ({
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end
  }),
  -- Debug Adapter Protocol UI
  -- filetypes are set in dap.lua
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {"mfussenegger/nvim-dap"},
    config = function()
      require("plug-config/dap")
    end
  },
  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      {
        "L3MON4D3/LuaSnip",
        dependencies = {"friendly-snippets", "vim-snippets"}
      },
      "rafamadriz/friendly-snippets",
      "honza/vim-snippets"
    }
  },
  -- icons
  "onsails/lspkind.nvim",
  -- Show keybindings
  -- use "liuchengxu/vim-which-key"
  "folke/which-key.nvim",
  -- vim-go
  {"fatih/vim-go", build = ":GoUpdateBinaries", ft = {"go"}},
  -- change surrounds
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },
  -- commenting
  "tpope/vim-commentary",
  -- fzf
  {"junegunn/fzf", build = ":call fzf#install()"},
  "junegunn/fzf.vim",
  -- set root folder automatically
  "airblade/vim-rooter",
  -- Git plugin
  "tpope/vim-fugitive",
  "tommcdo/vim-fubitive",
  "tpope/vim-rhubarb",
  "junegunn/gv.vim",
  "lewis6991/gitsigns.nvim",
  -- Formatting / prettier
  {
    "mhartington/formatter.nvim",
    build = "npm install -g lua-fmt nginxbeautifier prettier @prettier/plugin-xml @prettier/plugin-php && go install mvdan.cc/sh/v3/cmd/shfmt@latest"
  },
  -- use {"prettier/vim-prettier", build = "npm install && npm install -g @prettier/plugin-xml @prettier/plugin-php"}
  -- https://github.com/prettier/vim-prettier/pull/345
  {"Frederick888/vim-prettier", branch = "prettier-3-0", build = "npm install && npm install -g @prettier/plugin-xml @prettier/plugin-php"},
  -- tmux navigator
  "christoomey/vim-tmux-navigator",
  -- floatterm
  "voldikss/vim-floaterm",
  -- remote yank
  {"ojroques/nvim-osc52"},
  -- multiple cursor
  {"mg979/vim-visual-multi", branch = "master"},
  -- undootree
  "mbbill/undotree",
  -- highlight colors
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({user_default_options = {mode = "virtualtext", sass = {enable = false}}})
    end
  },
  -- colorpicker
  "KabbAmine/vCoolor.vim",
  -- Align (=Tab /<regexp>)
  "godlygeek/tabular",
  -- Enables repeat in other plugins
  "tpope/vim-repeat",
  -- Quick peek for Ctrl+R and @
  "junegunn/vim-peekaboo",
  -- closetags
  "alvan/vim-closetag",
  -- nginx support
  "chr4/nginx.vim",
  -- close-buffers
  "Asheq/close-buffers.vim",
  -- GitMessenger
  "rhysd/git-messenger.vim",
  -- mini-yank (fixes clipboard=unnamedplus block paste issue)
  "bfredl/nvim-miniyank",
  -- blankline, | between multiline {}
  "lukas-reineke/indent-blankline.nvim",
  -- VimWiki
  {
    "vimwiki/vimwiki",
    ft = "vimwiki",
    lazy = false,
    dependencies = {"michal-h21/vimwiki-sync"},
    init = function()
      vim.g.vimwiki_global_ext = 0 -- make sure vimwiki doesn't own all .md files },
      vim.g.sync_taskwarrior = 0 -- disable taskwarrior integration
      vim.g.vimwiki_list = {
        {
          path = "~/vimwiki/",
          syntax = "markdown",
          ext = ".md"
        }
      }
    end
  },
  -- restore cursor position on file open
  "farmergreg/vim-lastplace",
  -- bufferline (tabs)
  "akinsho/nvim-bufferline.lua",
  -- lualine, airline replacement
  "nvim-lualine/lualine.nvim",
  -- icons
  "nvim-tree/nvim-web-devicons",
  -- Scrollbar
  "petertriho/nvim-scrollbar",
  -- treesitter for highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring", -- javascript context commenting (different commenting to html tags and js parts on same file)
      "windwp/nvim-ts-autotag",
      {
        "CKolkey/ts-node-action",
        config = function()
          -- Optional
          require("ts-node-action").setup({})
        end
      }
    }
  },
  -- better text object support while using ex. ci"
  "wellle/targets.vim",
  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = {"markdown", "vim-plug"}
  },
  -- add sudo permission to write/read operations
  "lambdalisue/suda.vim",
  -- Show functions/methods <leader>lv
  "liuchengxu/vista.vim",
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {"nvim-telescope/telescope-media-files.nvim", build = "pip3 install --upgrade ueberzug"}
    }
  }, -- advanced git search to telescope
  {
    "aaronhallaert/ts-advanced-git-search.nvim",
    config = function()
      require("telescope").load_extension("advanced_git_search")
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      -- to show diff splits and open commits in browser
      "tpope/vim-fugitive"
    }
  },
  -- use "nvim-lua/popup.nvim"
  -- use 'nvim-telescope/telescope-fzf-native.nvim', { run= 'make' }
  -- Github copilot
  -- use "github/copilot.vim"
  {
    "zbirenbaum/copilot.lua",
    event = "VimEnter",
    config = function()
      vim.defer_fn(
        function()
          require("copilot").setup(
            {
              suggestion = {
                auto_trigger = true
              },
              filetypes = {
                yaml = true,
                markdown = true,
                help = false,
                gitcommit = false,
                gitrebase = false,
                hgcommit = false,
                svn = false,
                cvs = false,
                ["."] = false
              }
            }
          )
        end,
        100
      )
    end
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = {"copilot.lua"},
    config = function()
      require("copilot_cmp").setup()
    end
  },
  -- File explorer
  -- use 'kyazdani42/nvim-tree.lua'
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim"
    }
  },
  -- support for remote file editing. Does not work with vim-go
  -- use 'miversen33/netman.nvim', { branch= 'v1.1' } "support for remote

  -- % matches to functions etc
  "andymass/vim-matchup",
  -- Quick jumping around
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
      -- The below settings make Leap's highlighting a bit closer to what you've been
      -- used to in Lightspeed.
      vim.api.nvim_set_hl(0, "LeapBackdrop", {link = "Comment"})
      vim.api.nvim_set_hl(
        0,
        "LeapMatch",
        {
          fg = "white", -- for light themes, set to 'black' or similar
          bold = true,
          nocombine = true
        }
      )

      vim.api.nvim_set_hl(0, "LeapLabelPrimary", {fg = "#fb4934", bold = true, nocombine = true})
      vim.api.nvim_set_hl(0, "LeapLabelSecondary", {fg = "#b8bb26", bold = true, nocombine = true})

      -- keep old 'x' behaviour in visual mode
      vim.keymap.del({"x", "o"}, "x")
      vim.keymap.del({"x", "o"}, "X")
      require("leap").opts.highlight_unlabeled_phase_one_targets = true
    end
  },
  -- smooth scrolling
  "karb94/neoscroll.nvim",
  -- vscode like minimap/codewindow
  "gorbit99/codewindow.nvim",
  -- ChatGPT

  {
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup(
        {
          chat_layout = {
            size = {
              height = "90%",
              width = "90%"
            }
          }
        }
      )
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },
  -- better lsp ui

  {
    "glepnir/lspsaga.nvim",
    -- "racle/lspsaga.nvim",
    -- "/tmp/lspsaga.nvim/",
    branch = "main"
  },
  -- better folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup(
            {
              relculright = true,
              segments = {
                {text = {builtin.foldfunc}, click = "v:lua.ScFa"},
                {text = {"%s"}, click = "v:lua.ScSa"},
                {text = {builtin.lnumfunc, " "}, click = "v:lua.ScLa"}
              }
            }
          )
        end
      }
    }
  }
}

-- Gruvbox theme

-- if server-init exist then use it, else use the default
-- juicessh doesn't support gruvbox.nvim very well
if os.getenv("IS_SERVER") == "1" then
  table.insert(plugins, {"gruvbox-community/gruvbox", priority = 1000})
else
  table.insert(plugins, {"ellisonleao/gruvbox.nvim", priority = 1000})
end

return require("lazy").setup(plugins)
