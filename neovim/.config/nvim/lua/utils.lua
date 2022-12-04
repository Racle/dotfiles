local utils = {}

-- expand or minimize current buffer in "actual" direction
-- this is useful as mapping ":resize 2" stand-alone might otherwise not be in the right direction if mapped to ctrl-leftarrow or something related
-- use like this
--
-- vim.api.nvim_set_keymap("n", [[<A-Left>]], "<cmd>lua require('utils').resize(true, -2)<CR>", {silent=true, noremap=true})
-- vim.api.nvim_set_keymap("n", [[<A-Right>]], "<cmd>lua require('utils').resize(true, 2)<CR>", {silent=true, noremap=true})
-- vim.api.nvim_set_keymap("n", [[<A-Up>]], "<cmd>lua require('utils').resize(false, -2)<CR>", {silent=true, noremap=true})
-- vim.api.nvim_set_keymap("n", [[<A-Down>]], "<cmd>lua require('utils').resize(false, 2)<CR>", {silent=true, noremap=true})

utils.resize = function(vertical, margin)
  local cur_win = vim.api.nvim_get_current_win()
  -- go (possibly) right
  vim.cmd(string.format("wincmd %s", vertical and "l" or "j"))
  local new_win = vim.api.nvim_get_current_win()

  -- determine direction cond on increase and existing right-hand buffer
  local not_last = not (cur_win == new_win)
  local sign = margin > 0
  -- go to previous window if required otherwise flip sign
  if not_last == true then
    vim.cmd [[wincmd p]]
  else
    sign = not sign
  end

  sign = sign and "+" or "-"
  local dir = vertical and "vertical " or ""
  local cmd = dir .. "resize " .. sign .. math.abs(margin) .. "<CR>"
  vim.cmd(cmd)
end

function utils.so_input()
  local buf = vim.api.nvim_get_current_buf()
  file_type = vim.api.nvim_buf_get_option(buf, "filetype")
  vim.ui.input(
    {prompt = "StackOverflow input: ", default = file_type .. " "},
    function(input)
      local cmd = ""
      if input == "" or not input then
        return
      elseif input == "h" then
        cmd = "-h"
      else
        cmd = input
      end
      vim.cmd(":FloatermNew " .. "so --no-lucky " .. cmd)
    end
  )
end

return utils
