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
      }
    }

    -- Autocompletion
    use {
      "hrsh7th/nvim-cmp",
      requires = {"hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip"}
    }

    -- Show keybindings
    -- use "liuchengxu/vim-which-key"
    use {
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup {}
      end
    }

    use "onsails/lspkind.nvim"

    -- vim-go
    use {"fatih/vim-go", run = ":GoUpdateBinaries", ft = {"go"}}
    -- Automatic surround
    use "tpope/vim-surround"
    -- commenting
    use "tpope/vim-commentary"
    -- Gruvbox theme
    use "gruvbox-community/gruvbox"
    -- fzf
    use {"junegunn/fzf", run = ":call fzf#install()"}
    use "junegunn/fzf.vim"
    use "airblade/vim-rooter"
    -- Neovim library plugin
    use "nvim-lua/plenary.nvim"
    -- Git plugin
    use "tpope/vim-fugitive"
    use "tommcdo/vim-fubitive"
    use "tpope/vim-rhubarb"
    use "junegunn/gv.vim"
    use "lewis6991/gitsigns.nvim"
    -- Formatting / prettier
    use {
      "mhartington/formatter.nvim",
      run = "npm install -g lua-fmt nginxbeautifier prettier @prettier/plugin-xml @prettier/plugin-php"
    }
    use {"prettier/vim-prettier", run = "npm install && npm install -g @prettier/plugin-xml @prettier/plugin-php"}
    -- tagalong (tag autochange)
    use "andrewradev/tagalong.vim"
    -- tmux navigator
    use "christoomey/vim-tmux-navigator"
    -- floatterm
    use "voldikss/vim-floaterm"
    -- vim lessc
    use {"vitalk/vim-lesscss", run = "npm install -g less minify"}
    -- remote yank
    use {"ojroques/vim-oscyank", branch = "main"}
    -- Snippets
    use "honza/vim-snippets"
    -- Quickscope
    use "unblevable/quick-scope"
    -- multiple cursor
    use {"mg979/vim-visual-multi", branch = "master"}
    -- undootree
    use "mbbill/undotree"
    -- colorpicker
    -- use 'ap/vim-css-color' coc-css does same thing
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
    use "vimwiki/vimwiki"
    use "michal-h21/vimwiki-sync"
    -- restore cursor position on file open
    use "farmergreg/vim-lastplace"
    -- bufferline (tabs)
    use "akinsho/nvim-bufferline.lua"
    -- lualine, airline replacement
    use "nvim-lualine/lualine.nvim"
    -- icons
    use "kyazdani42/nvim-web-devicons"
    -- Scrollbar
    use {"dstein64/nvim-scrollview", branch = "main"}
    -- treesitter for highlighting
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    use "nvim-treesitter/nvim-treesitter-textobjects"
    -- javascript context commenting (different commenting to html tags and js parts on same file)
    use "JoosepAlviste/nvim-ts-context-commentstring"
    -- better text object support while using ex. ci"
    use "wellle/targets.vim"
    -- Markdown preview
    use {"iamcco/markdown-preview.nvim", run = ":call mkdp#util#install()", ft = {"markdown", "vim-plug"}}
    -- add sudo permission to write/read operations
    use "lambdalisue/suda.vim"
    -- Show functions/methods <leader>lv
    use "liuchengxu/vista.vim"
    -- Better wildmenu
    use {"gelguy/wilder.nvim", run = ":UpdateRemoteuseins"}
    -- extra library
    use "MunifTanjim/nui.nvim"
    -- Telescope
    use "nvim-telescope/telescope.nvim"
    use "nvim-lua/popup.nvim"
    use {"nvim-telescope/telescope-media-files.nvim", run = "pip3 install --upgrade ueberzug"}
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
    use {"nvim-neo-tree/neo-tree.nvim", branch = "v2.x"}
    -- file editing. Does not work with vim-go
    -- use 'miversen33/netman.nvim', { branch= 'v1.1' } "support for remote

    -- Database view/explorer
    use "tpope/vim-dadbod"
    use "kristijanhusak/vim-dadbod-ui"
    -- % matches to functions etc
    use "andymass/vim-matchup"
    -- Quick jumping around
    use "ggandor/lightspeed.nvim"
    -- smooth scrolling
    use "karb94/neoscroll.nvim"
    -- vscode like minimap/codewindow
    use "gorbit99/codewindow.nvim"

    if packer_bootstrap then
      require("packer").sync()
    end
  end
)
