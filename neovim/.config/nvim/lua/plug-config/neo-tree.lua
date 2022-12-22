-- require("netman")
require("neo-tree").setup(
  {
    toggle = true,
    sources = {
      "filesystem" -- Neotree filesystem source
      -- "netman.ui.neo-tree" -- The one you really care about 😉
    },
    window = {
      mappings = {
        ["h"] = "close_node",
        ["l"] = "open",
        ["a"] = {
          "add",
          -- some commands may take optional config options, see `:h neo-tree-mappings` for details
          config = {
            show_path = "relative" -- "none", "relative", "absolute"
          }
        },
        ["c"] = {
          "copy",
          -- some commands may take optional config options, see `:h neo-tree-mappings` for details
          config = {
            show_path = "relative" -- "none", "relative", "absolute"
          }
        },
        ["Z"] = "expand_all_nodes",
        -- remove keybindings
        ["<space>"] = "",
        ["<"] = "",
        [">"] = ""
      }
    },
    filesystem = {
      follow_current_file = true,
      filtered_items = {
        visible = false,
        hide_dotfiles = true,
        hide_by_pattern = {
          -- uses glob style patterns
          ".git",
          ".vim",
          "node_modules"
        }
      }
    },
    buffers = {
      follow_current_file = true, -- This will find and focus the file in the active buffer every
      group_empty_dirs = true, -- when true, empty folders will be grouped together
      show_unloaded = true
    }
  }
)
