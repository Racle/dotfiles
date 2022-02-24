local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local custom_actions = {}

function custom_actions._multiopen(prompt_bufnr, open_cmd)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local selected_entry = action_state.get_selected_entry()
  local num_selections = #picker:get_multi_selection()
  if not num_selections or num_selections <= 1 then
    actions.add_selection(prompt_bufnr)
  end
  actions.send_selected_to_qflist(prompt_bufnr)
  vim.cmd("cfdo " .. open_cmd)
end
function custom_actions.multi_selection_open_vsplit(prompt_bufnr)
  custom_actions._multiopen(prompt_bufnr, "vsplit")
end
function custom_actions.multi_selection_open_split(prompt_bufnr)
  custom_actions._multiopen(prompt_bufnr, "split")
end
function custom_actions.multi_selection_open_tab(prompt_bufnr)
  custom_actions._multiopen(prompt_bufnr, "tabe")
end
function custom_actions.multi_selection_open(prompt_bufnr)
  custom_actions._multiopen(prompt_bufnr, "edit")
end

function custom_actions.multi_selection_open_vsplit(prompt_bufnr)
  custom_actions._multiopen(prompt_bufnr, "vsplit")
end
function custom_actions.multi_selection_open_split(prompt_bufnr)
  custom_actions._multiopen(prompt_bufnr, "split")
end
function custom_actions.multi_selection_open(prompt_bufnr)
  custom_actions._multiopen(prompt_bufnr, "edit")
end

require("telescope").setup {
  defaults = {
    preview = {
      filesize_hook = function(filepath, bufnr, opts)
        local max_bytes = 10000
        local cmd = {"head", "-c", max_bytes, filepath}
        require("telescope.previewers.utils").job_maker(cmd, bufnr, opts)
      end
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--hidden",
      "--smart-case"
    },
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    file_ignore_patterns = {
      "%.git/.*",
      "%.vim/.*",
      "node_modules/.*",
      "%.idea/.*",
      "%.vscode/.*",
      "%.history/.*"
    },
    layout_config = {
      vertical = {
        mirror = true
      },
      width = 0.93,
      prompt_position = "top"
    },
    mappings = {
      i = {
        ["<ESC>"] = actions.close,
        ["<C-J>"] = actions.move_selection_next,
        ["<C-K>"] = actions.move_selection_previous,
        ["<C-TAB>"] = actions.toggle_selection,
        ["<TAB>"] = actions.toggle_selection + actions.move_selection_next,
        ["<S-TAB>"] = actions.toggle_selection + actions.move_selection_previous,
        ["<CR>"] = custom_actions.multi_selection_open,
        ["<C-V>"] = custom_actions.multi_selection_open_vsplit,
        ["<C-S>"] = custom_actions.multi_selection_open_split,
        ["<C-T>"] = custom_actions.multi_selection_open_tab,
        ["<C-DOWN>"] = require("telescope.actions").cycle_history_next,
        ["<C-UP>"] = require("telescope.actions").cycle_history_prev
      },
      n = i
    }
  },
  extensions = {
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = {"png", "webp", "jpg", "jpeg", "pdf"},
      find_cmd = "rg" -- find command (defaults to `fd`)
    }
    -- fzf = {
    --   fuzzy = true, -- false will only do exact matching
    --   override_generic_sorter = true, -- override the generic sorter
    --   override_file_sorter = true, -- override the file sorter
    --   case_mode = "smart_case" -- or "ignore_case" or "respect_case"
    --   -- the default case_mode is "smart_case"
    -- }
  }
}

require("telescope").load_extension("media_files")
-- require("telescope").load_extension("fzf")
