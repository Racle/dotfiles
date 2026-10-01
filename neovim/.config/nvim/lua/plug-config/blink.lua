-- blink.cmp setup
vim.api.nvim_set_hl(0, "BlinkCmpKindCopilot", {fg = "#6CC644"})

require("blink.cmp").setup(
  {
    keymap = {
      preset = "none",
      ["<C-d>"] = {"scroll_documentation_up", "fallback"},
      ["<C-f>"] = {"scroll_documentation_down", "fallback"},
      ["<C-Space>"] = {"show", "show_documentation", "hide_documentation"},
      ["<C-e>"] = {"cancel", "fallback"},
      ["<CR>"] = {"accept", "fallback"},
      ["<Tab>"] = {
        "select_next",
        "snippet_forward",
        function()
          local ls = require("luasnip")
          if ls.expandable() then
            vim.schedule(
              function()
                ls.expand()
              end
            )
            return true
          end
        end,
        "fallback"
      },
      ["<S-Tab>"] = {"select_prev", "snippet_backward", "fallback"},
      ["<C-n>"] = {"select_next", "show", "fallback"},
      ["<C-p>"] = {"select_prev", "show", "fallback"},
      ["§"] = {"hide", "fallback"}
    },
    snippets = {preset = "luasnip"},
    appearance = {
      kind_icons = {Copilot = ""}
    },
    completion = {
      keyword = {range = "full"},
      ghost_text = {enabled = true},
      documentation = {auto_show = true},
      list = {selection = {preselect = true, auto_insert = false}},
      menu = {
        draw = {
          components = {
            kind_icon = {
              text = function(ctx)
                if ctx.source_name == "Path" then
                  local icon = require("nvim-web-devicons").get_icon(ctx.label)
                  if icon then
                    return icon .. ctx.icon_gap
                  end
                end
                return ctx.kind_icon .. ctx.icon_gap
              end,
              highlight = function(ctx)
                if ctx.source_name == "Path" then
                  local _, hl = require("nvim-web-devicons").get_icon(ctx.label)
                  if hl then
                    return hl
                  end
                end
                return "BlinkCmpKind" .. ctx.kind
              end
            }
          }
        }
      }
    },
    sources = {
      default = {"lsp", "path", "snippets", "copilot"},
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true
        }
      }
    },
    cmdline = {
      enabled = true,
      keymap = {preset = "cmdline"},
      completion = {menu = {auto_show = true}}
    },
    signature = {enabled = true}
  }
)
