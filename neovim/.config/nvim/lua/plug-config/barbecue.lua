vim.api.nvim_create_autocmd(
  {
    "WinScrolled",
    "BufWinEnter",
    "CursorHold",
    "InsertLeave",
    -- include these if you have set `show_modified` to `true`
    "BufWritePost",
    "TextChanged",
    "TextChangedI"
  },
  {
    group = vim.api.nvim_create_augroup("barbecue#create_autocmd", {}),
    callback = function()
      require("barbecue.ui").update()
    end
  }
)

local function loadBarbacue()
  local bg = "#313131"
  require("barbecue").setup(
    {
      -- prevent barbecue from updating itself automatically
      create_autocmd = false,
      theme = {
        normal = {bg = bg},
        context = {bg = bg},
        separator = {bg = bg},
        basename = {bg = bg},
        dirname = {bg = bg},
        ellipsis = {bg = bg},
        modified = {bg = bg},
        context_key = {bg = bg},
        context_enum = {bg = bg},
        context_file = {bg = bg},
        context_null = {bg = bg},
        fileicon_Lua = {bg = bg},
        fileicon_Vim = {bg = bg},
        context_array = {bg = bg},
        context_class = {bg = bg},
        context_event = {bg = bg},
        context_field = {bg = bg},
        context_method = {bg = bg},
        context_module = {bg = bg},
        context_number = {bg = bg},
        context_object = {bg = bg},
        context_string = {bg = bg},
        context_struct = {bg = bg},
        context_boolean = {bg = bg},
        context_package = {bg = bg},
        context_constant = {bg = bg},
        context_function = {bg = bg},
        context_operator = {bg = bg},
        context_property = {bg = bg},
        context_variable = {bg = bg},
        context_interface = {bg = bg},
        context_namespace = {bg = bg},
        context_constructor = {bg = bg},
        context_enum_member = {bg = bg},
        context_type_parameter = {bg = bg}
      }
    }
  )
end

-- hack to load barbecue because it wouldn't set theme otherwise
local timer = vim.loop.new_timer()
timer:start(
  100,
  0,
  vim.schedule_wrap(
    function()
      loadBarbacue()
      timer:close()
    end
  )
)
