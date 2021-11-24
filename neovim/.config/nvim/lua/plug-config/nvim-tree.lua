local tree_cb = require "nvim-tree.config".nvim_tree_callback

local list = {
  {key = "h", cb = tree_cb("close_node")},
  {key = "l", cb = tree_cb("edit")}
}

require "nvim-tree".setup {
  disable_netrw = false,
  hijack_cursor = true,
  update_cwd = true,
  diagnostics = {
    enable = true
  },
  view = {
    auto_resize = true,
    width = 40,
    mappings = {
      list = list
    }
  }
}
