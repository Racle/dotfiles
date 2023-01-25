require("lspsaga").setup(
  {
    ui = {
      colors = {
        --float window normal bakcground color
        normal_bg = "#313131"
        --title background color
        -- title_bg = "#313131"
      }
    },
    symbol_in_winbar = {
      enable = true,
      separator = "  ",
      hide_keyword = true,
      show_file = true,
      folder_level = 2,
      respect_root = false,
      color_mode = true
    },
    lightbulb = {
      sign = false
    },
    rename = {
      in_select = false
    }
  }
)

-- custom winbar colors
vim.cmd [[hi WinBar guibg=#313131]]
vim.cmd [[hi WinBarNC guibg=#313131]]
vim.cmd [[hi LspSagaWinbarObject guibg=#313131]]
vim.cmd [[hi LspSagaWinbarClass guibg=#313131]]
vim.cmd [[hi LspSagaWinbarSep guibg=#313131]]
vim.cmd [[hi LspSagaWinbarKey guibg=#313131]]
vim.cmd [[hi LspSagaWinbarEnum guibg=#313131]]
vim.cmd [[hi LspSagaWinbarFile guibg=#313131]]
vim.cmd [[hi LspSagaWinbarNull guibg=#313131]]
vim.cmd [[hi LspSagaWinbarText guibg=#313131]]
vim.cmd [[hi LspSagaWinbarUnit guibg=#313131]]
vim.cmd [[hi LspSagaWinbarWord guibg=#313131]]
vim.cmd [[hi LspSagaWinbarArray guibg=#313131]]
vim.cmd [[hi LspSagaWinbarEvent guibg=#313131]]
vim.cmd [[hi LspSagaWinbarField guibg=#313131]]
vim.cmd [[hi LspSagaWinbarMacro guibg=#313131]]
vim.cmd [[hi LspSagaWinbarValue guibg=#313131]]
vim.cmd [[hi LspSagaWinbarFolder guibg=#313131]]
vim.cmd [[hi LspSagaWinbarMethod guibg=#313131]]
vim.cmd [[hi LspSagaWinbarModule guibg=#313131]]
vim.cmd [[hi LspSagaWinbarNumber guibg=#313131]]
vim.cmd [[hi LspSagaWinbarString guibg=#313131]]
vim.cmd [[hi LspSagaWinbarStruct guibg=#313131]]
vim.cmd [[hi LspSagaWinbarBoolean guibg=#313131]]
vim.cmd [[hi LspSagaWinbarPackage guibg=#313131]]
vim.cmd [[hi LspSagaWinbarSnippet guibg=#313131]]
vim.cmd [[hi LspSagaWinbarConstant guibg=#313131]]
vim.cmd [[hi LspSagaWinbarFunction guibg=#313131]]
vim.cmd [[hi LspSagaWinbarOperator guibg=#313131]]
vim.cmd [[hi LspSagaWinbarProperty guibg=#313131]]
vim.cmd [[hi LspSagaWinbarVariable guibg=#313131]]
vim.cmd [[hi LspSagaWinbarInterface guibg=#313131]]
vim.cmd [[hi LspSagaWinbarNamespace guibg=#313131]]
vim.cmd [[hi LspSagaWinbarParameter guibg=#313131]]
vim.cmd [[hi LspSagaWinbarTypeAlias guibg=#313131]]
vim.cmd [[hi LspSagaWinbarEnumMember guibg=#313131]]
vim.cmd [[hi LspSagaWinbarFolderName guibg=#313131]]
vim.cmd [[hi LspSagaWinbarConstructor guibg=#313131]]
vim.cmd [[hi LspSagaWinbarStaticMethod guibg=#313131]]
vim.cmd [[hi LspSagaWinbarTypeParameter guibg=#313131]]
vim.cmd [[hi LspSagaWinbarFileIcon guibg=#313131]]

----TODO fix keymap
--local keymap = vim.keymap.set
---- Lsp finder find the symbol definition implement reference
---- if there is no implement it will hide
---- when you use action in finder like open vsplit then you can
---- use <C-t> to jump back
--keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

---- Code action
--keymap({"n", "v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

---- Rename
--keymap("n", "gr", "<cmd>Lspsaga rename<CR>")

---- Rename word in whole project
--keymap("n", "gr", "<cmd>Lspsaga rename ++project<CR>")

---- Peek Definition
---- you can edit the definition file in this float window
---- also support open/vsplit/etc operation check definition_action_keys
---- support tagstack C-t jump back
--keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>")

---- Go to Definition
--keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>")

---- Show line diagnostics you can pass argument ++unfocus to make
---- show_line_diagnostics float window unfocus
--keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

---- Show cursor diagnostic
---- also like show_line_diagnostics  support pass ++unfocus
--keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

---- Show buffer diagnostic
--keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

---- Diagnostic jump can use `<c-o>` to jump back
--keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
--keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

---- Diagnostic jump with filter like Only jump to error
--keymap(
--  "n",
--  "[E",
--  function()
--    require("lspsaga.diagnostic"):goto_prev({severity = vim.diagnostic.severity.ERROR})
--  end
--)
--keymap(
--  "n",
--  "]E",
--  function()
--    require("lspsaga.diagnostic"):goto_next({severity = vim.diagnostic.severity.ERROR})
--  end
--)

---- Toggle Outline
---- keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>")

---- Hover Doc
---- if there has no hover will have a notify no information available
---- to disable it just Lspsaga hover_doc ++quiet
---- press twice it will jump into hover window
--keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")
---- if you want keep hover window in right top you can use ++keep arg
---- notice if you use hover with ++keep you press this keymap it will
---- close the hover window .if you want jump to hover window must use
---- wincmd command <C-w>w
--keymap("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>")

---- Callhierarchy
--keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
--keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")
