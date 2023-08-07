local sources = require("dropbar.sources")

local function get_hl_color(group, attr)
  return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr)
end

local get_symbols = function(buf, win, cursor, symbols)
  local path = false
  if symbols == nil then
    symbols = sources.path.get_symbols(buf, win, cursor)
    path = true
  end
  for _, symbol in ipairs(symbols) do
    -- get correct icon color
    local icon_fg = get_hl_color(symbol.icon_hl, "fg#")
    symbol.icon_hl = "DropbarSymbol" .. symbol.icon_hl

    -- set name highlight
    if not path then
      symbol.name_hl = symbol.icon_hl
    end

    local icon_string = ""
    if icon_fg == "" then
      icon_string = "hi " .. symbol.icon_hl .. " guisp=#665c54 gui=underline guibg=#313131"
    else
      icon_string = "hi " .. symbol.icon_hl .. " guisp=#665c54 gui=underline guibg=#313131 guifg=" .. icon_fg
    end

    vim.cmd(icon_string)
  end
  return symbols
end

vim.cmd [[hi WinBar guisp=#665c54 gui=underline guibg=#313131]]
vim.cmd [[hi WinBarNC guisp=#665c54 gui=underline guibg=#313131]]
vim.cmd [[hi DropBarIconUISeparator guisp=#665c54 gui=underline guibg=#313131 guifg=#fe8019]]

require("dropbar").setup(
  {
    icons = {
      ui = {
        bar = {
          separator = "  "
        }
      }
    },
    bar = {
      sources = function(_, _, _)
        return {
          {
            get_symbols = get_symbols
          },
          {
            get_symbols = function(buf, win, cursor) -- buf, win, cursor
              if vim.bo[buf].ft == "markdown" then
                return sources.markdown.get_symbols(buf, win, cursor)
              end
              for _, source in ipairs(
                {
                  sources.lsp,
                  sources.treesitter
                }
              ) do
                return get_symbols(buf, win, cursor, source.get_symbols(buf, win, cursor))
              end
              return {}
            end
          }
        }
      end
    }
  }
)
