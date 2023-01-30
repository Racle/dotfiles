local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- run :PackerCompile whenever plugins.lua is updated with
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup(
  function(use)
    use {"wbthomason/packer.nvim"}

    use {
      -- LSP Configuration & Plugins
      "neovim/nvim-lspconfig",
      requires = {
        -- Automatically install LSPs to stdpath for neovim
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        -- Useful status updates for LSP
        "j-hui/fidget.nvim"
      },
      run = "pip install ansible-lint"
    }
    -- better lsp errors
    use(
      {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
          require("lsp_lines").setup()
        end
      }
    )
    -- Debug Adapter Protocol UI
    -- filetypes are set in dap.lua
    use {
      "rcarriga/nvim-dap-ui",
      requires = {"mfussenegger/nvim-dap"},
      config = function()
        require("plug-config/dap")
      end
    }

    -- Autocompletion
    use {
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/cmp-nvim-lsp",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-calc",
        {
          "L3MON4D3/LuaSnip",
          wants = {"friendly-snippets", "vim-snippets"}
        },
        "rafamadriz/friendly-snippets",
        "honza/vim-snippets"
      }
    }
    -- icons
    use "onsails/lspkind.nvim"

    -- Show keybindings
    -- use "liuchengxu/vim-which-key"
    use {
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup({})
      end
    }

    -- vim-go
    use {"fatih/vim-go", run = ":GoUpdateBinaries", ft = {"go"}}
    -- change surrounds
    use(
      {
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
          require("nvim-surround").setup({})
        end
      }
    )
    -- commenting
    use "tpope/vim-commentary"
    -- Gruvbox theme
    use "ellisonleao/gruvbox.nvim"
    -- fzf
    use {"junegunn/fzf", run = ":call fzf#install()"}
    use "junegunn/fzf.vim"
    -- set root folder automatically
    use "airblade/vim-rooter"
    -- Git plugin
    use "tpope/vim-fugitive"
    use "tommcdo/vim-fubitive"
    use "tpope/vim-rhubarb"
    use "junegunn/gv.vim"
    use "lewis6991/gitsigns.nvim"
    -- Formatting / prettier
    use {
      "mhartington/formatter.nvim",
      run = "npm install -g lua-fmt nginxbeautifier prettier @prettier/plugin-xml @prettier/plugin-php && go install mvdan.cc/sh/v3/cmd/shfmt@latest"
    }
    use {"prettier/vim-prettier", run = "npm install && npm install -g @prettier/plugin-xml @prettier/plugin-php"}
    -- tagalong (tag autochange)
    use "andrewradev/tagalong.vim"
    -- tmux navigator
    use "christoomey/vim-tmux-navigator"
    -- floatterm
    use "voldikss/vim-floaterm"
    -- remote yank
    use {"ojroques/vim-oscyank", branch = "main"}
    -- multiple cursor
    use {"mg979/vim-visual-multi", branch = "master"}
    -- undootree
    use "mbbill/undotree"
    -- highlight colors
    use {
      "NvChad/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup({user_default_options = {mode = "virtualtext", sass = {enable = false}}})
      end
    }
    -- colorpicker
    use "KabbAmine/vCoolor.vim"
    -- Align (=Tab /<regexp>)
    use "godlygeek/tabular"
    -- Enables repeat in other plugins
    use "tpope/vim-repeat"
    -- Quick peek for Ctrl+R and @
    use "junegunn/vim-peekaboo"
    -- closetags
    use "alvan/vim-closetag"
    -- nginx support
    use "chr4/nginx.vim"
    -- close-buffers
    use "Asheq/close-buffers.vim"
    -- GitMessenger
    use "rhysd/git-messenger.vim"
    -- mini-yank (fixes clipboard=unnamedplus block paste issue)
    use "bfredl/nvim-miniyank"
    -- blankline, | between multiline {}
    use "lukas-reineke/indent-blankline.nvim"
    -- VimWiki
    use {
      "vimwiki/vimwiki",
      requires = {"michal-h21/vimwiki-sync"}
    }
    -- restore cursor position on file open
    use "farmergreg/vim-lastplace"
    -- bufferline (tabs)
    use "akinsho/nvim-bufferline.lua"
    -- lualine, airline replacement
    use "nvim-lualine/lualine.nvim"
    -- icons
    use "kyazdani42/nvim-web-devicons"
    -- Scrollbar
    use "petertriho/nvim-scrollbar"
    -- treesitter for highlighting
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      requires = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "JoosepAlviste/nvim-ts-context-commentstring", -- javascript context commenting (different commenting to html tags and js parts on same file)
        {
          "CKolkey/ts-node-action",
          config = function()
            -- Optional
            require("ts-node-action").setup({})
          end
        }
      }
    }
    -- better text object support while using ex. ci"
    use "wellle/targets.vim"
    -- Markdown preview
    use {
      "iamcco/markdown-preview.nvim",
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
      ft = {"markdown", "vim-plug"}
    }
    -- add sudo permission to write/read operations
    use "lambdalisue/suda.vim"
    -- Show functions/methods <leader>lv
    use "liuchengxu/vista.vim"
    -- Telescope
    use {
      "nvim-telescope/telescope.nvim",
      requires = {"nvim-lua/plenary.nvim", {"nvim-telescope/telescope-media-files.nvim", run = "pip3 install --upgrade ueberzug"}}
    }
    -- use "nvim-lua/popup.nvim"
    -- use 'nvim-telescope/telescope-fzf-native.nvim', { run= 'make' }
    -- Github copilot
    -- use "github/copilot.vim"
    use {
      "zbirenbaum/copilot.lua",
      event = "VimEnter",
      config = function()
        vim.defer_fn(
          function()
            require("copilot").setup(
              {
                suggestion = {
                  auto_trigger = true
                }
              }
            )
          end,
          100
        )
      end
    }
    use {
      "zbirenbaum/copilot-cmp",
      after = {"copilot.lua"},
      config = function()
        require("copilot_cmp").setup()
      end
    }
    -- File explorer
    -- use 'kyazdani42/nvim-tree.lua'
    use {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim"
      }
    }
    -- support for remote file editing. Does not work with vim-go
    -- use 'miversen33/netman.nvim', { branch= 'v1.1' } "support for remote

    -- % matches to functions etc
    use "andymass/vim-matchup"
    -- Quick jumping around
    use {
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
        -- keep old 'x' behaviour in visual mode
        vim.keymap.del({"x", "o"}, "x")
        vim.keymap.del({"x", "o"}, "X")
        require("leap").opts.highlight_unlabeled_phase_one_targets = true
      end
    }
    -- smooth scrolling
    use "karb94/neoscroll.nvim"
    -- vscode like minimap/codewindow
    use "gorbit99/codewindow.nvim"
    -- ChatGPT
    use(
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
        requires = {
          "MunifTanjim/nui.nvim",
          "nvim-lua/plenary.nvim",
          "nvim-telescope/telescope.nvim"
        }
      }
    )
    -- better lsp ui
    use(
      {
        "glepnir/lspsaga.nvim",
        branch = "main"
      }
    )
    if packer_bootstrap then
      require("packer").sync()
    end
  end
)
