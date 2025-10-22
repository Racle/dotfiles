-- nvim-cmp setup
local cmp = require "cmp"
local luasnip = require "luasnip"

-- lspind
-- :call tagalong#Apply()
local lspkind = require("lspkind")
lspkind.init(
  {
    symbol_map = {
      Copilot = ""
    }
  }
)

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg = "#6CC644"})

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace
      -- select = true
    },
    -- https://github.com/zbirenbaum/copilot.lua/issues/91#issuecomment-1345190310
    ["<Tab>"] = cmp.mapping(
      function(fallback)
        -- if cmp is visible, select item in list
        -- if luasnip is expandable but gopilot suggestion is shown, ignore luasnip
        -- if copilot is visible and cmp is hidden, accept suggestion
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() and not require("copilot.suggestion").is_visible() then
          luasnip.expand_or_jump()
        elseif require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept()
        else
          fallback()
        end
      end,
      {
        "i",
        "s"
      }
    ),
    ["<S-Tab>"] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end,
      {"i", "s"}
    ),
    ["§"] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.abort()
        elseif require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").dismiss()
        else
          fallback()
        end
      end,
      {"i", "s"}
    ),
    ["<Esc>"] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.abort()
        elseif require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").dismiss()
        else
          fallback()
        end
      end,
      {"i", "s"}
    ),
    ["<C-c>"] = cmp.mapping(
      function(fallback)
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").dismiss()
          fallback()
        else
          fallback()
        end
      end,
      {"i", "s"}
    ),
    ["<C-k>"] = cmp.mapping(
      function(fallback)
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").prev()
        else
          fallback()
        end
      end,
      {"i", "s"}
    ),
    ["<C-j>"] = cmp.mapping(
      function(fallback)
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").next()
        else
          fallback()
        end
      end,
      {"i", "s"}
    )
  },
  sources = {
    -- Copilot Source
    {name = "copilot", group_index = 2},
    -- Other Sources
    {name = "nvim_lsp", group_index = 2},
    {name = "path", group_index = 2},
    {name = "luasnip"},
    {name = "calc"}
  },
  formatting = {
    format = function(entry, vim_item)
      if vim.tbl_contains({"path"}, entry.source.name) then
        local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
        if icon then
          vim_item.kind = icon
          vim_item.kind_hl_group = hl_group
          return vim_item
        end
      end
      return lspkind.cmp_format({with_text = true})(entry, vim_item)
    end
  },
  experimental = {
    ghost_text = true -- this feature conflict with copilot.vim's preview.
  }
}

-- Override mapping only for CopilotChat buffers
-- After confirming a completion, send <C-c>o to close completion window and go to new line
-- cmp.setup.filetype(
--   "copilot-chat",
--   {
--     mapping = {
--       ["<CR>"] = cmp.mapping(
--         function(fallback)
--           if cmp.visible() then
--             cmp.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true})
--             vim.schedule(
--               function()
--                 vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>o", true, false, true), "n", true)
--               end
--             )
--           else
--             fallback()
--           end
--         end,
--         {"i", "s"}
--       )
--     }
--   }
-- )

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  {"/", "?"},
  {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      {name = "buffer"}
    }
  }
)

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  ":",
  {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
      {
        {name = "path"}
      },
      {
        {name = "cmdline"}
      }
    )
  }
)
