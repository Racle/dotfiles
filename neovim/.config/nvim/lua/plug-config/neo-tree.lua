-- require("netman")
require("neo-tree").setup(
  {
    toggle = true,
    sources = {
      "filesystem", -- Neotree filesystem source
      "buffers",
      "git_status"
      -- "netman.ui.neo-tree" -- The one you really care about 😉
    },
    source_selector = {
      winbar = true,
      statusline = false
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
            show_path = "absolute" -- "none", "relative", "absolute"
          }
        },
        ["Z"] = "expand_all_nodes",
        -- remove keybindings
        ["<space>"] = "",
        ["<"] = "next_source",
        [">"] = "prev_source",
        ["H"] = function(state)
          state.commands.toggle_hidden(state)
          -- print(vim.inspect(state), state.filtered_items.visible)

          -- hack to force following current file after unhiding
          if (state.filtered_items.visible) then
            -- change back to current file
            vim.cmd("wincmd l")
            -- set 100ms timer to change back to neotree
            local timer = vim.loop.new_timer()
            timer:start(
              100,
              0,
              vim.schedule_wrap(
                function()
                  vim.cmd("10wincmd h")
                end
              )
            )
          end
        end
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
