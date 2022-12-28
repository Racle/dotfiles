-- Other mappings locations:
-- lua/plug-config/which-key.lua
-- lua/general/mappings.lua
-- lua/plug-config/bufferline.lua
-- lua/plug-config/telescope.lua
-- plug-config/go.vim

-- map helper
local map = function(type, keys, func, desc, noremap)
  noremap = noremap or false
  vim.keymap.set(type, keys, func, {noremap = noremap, desc = desc})
end

-- leadermap with CR
local lmapCR = function(type, keys, func, desc, noremap)
  map(type, "<leader>" .. keys, func .. "<CR>", desc, noremap)
end

-- leadermap
local lmap = function(type, keys, func, desc, noremap)
  map(type, "<leader>" .. keys, func, desc, noremap)
end

vim.g.mapleader = " "

-- better 0 (goes start of line/first character)
local goToFirstCharOrLineRegex = "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'"
vim.api.nvim_set_keymap("v", "0", goToFirstCharOrLineRegex, {silent = true, noremap = true, expr = true})
vim.api.nvim_set_keymap("n", "0", goToFirstCharOrLineRegex, {silent = true, noremap = true, expr = true})

vim.api.nvim_set_keymap("n", [[<A-h>]], "<cmd>lua require('utils').resize(true, -2)<CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", [[<A-l>]], "<cmd>lua require('utils').resize(true, 2)<CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", [[<A-k>]], "<cmd>lua require('utils').resize(false, -2)<CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", [[<A-j>]], "<cmd>lua require('utils').resize(false, 2)<CR>", {silent = true, noremap = true})

-- Map § to Esc
vim.keymap.set("i", "§", "<Esc>", {noremap = true})
vim.keymap.set("t", "§", "<Esc>", {noremap = true})
vim.keymap.set("n", "§", "<Esc>", {noremap = true})
vim.keymap.set("x", "§", "<Esc>", {noremap = true})

-- Quickly insert an empty new line without entering insert mode
lmap("n", "o", "o<Esc>", "New line down", true)
lmap("n", "O", "O<Esc>", "New line up", true)

-- <leader>
lmapCR("n", "e", ":Neotree toggle", "Explorer")
lmapCR("n", "n", ":Telescope find_files hidden=true", "Search files")
lmapCR("n", "q", ":call CloseThisBuffer()", "close-buffer")
lmapCR("n", "Q", ":ccl", "close quickfix")
lmapCR("n", "p", ":Prettier", "Prettier")

-- <leader>f find
lmapCR("n", "fo", ":Telescope oldfiles hidden=true", "Search oldfiles")
lmapCR("n", "ff", ":Telescope live_grep", "Search files")
lmapCR("n", "fr", ":Rg", "Search files (rg)")
lmapCR("n", "fF", ":RgFileExt *.", "Search test with ext")
lmapCR("n", "fb", ":Telescope buffers", "Search buffers")
lmapCR("n", "fq", ":Telescope quickfix", "Search quickfix")
lmapCR("n", "fh", ":Telescope help_tags", "Search help")
lmapCR("n", "fn", ":Telescope find_files hidden=true", "Search files")
lmapCR("n", "fm", ":Telescope media_files", "Search media files")
lmapCR("n", "fv", ":Vista finder coc", "Search functions")
lmapCR("n", "f_", ":RooterToggle", "Toggle vim-rooter")

-- <leader>fg find git
lmapCR("n", "fgc", ":Telescope git_commits", "Search commits")
lmapCR("n", "fgb", ":Telescope git_bcommits", "Search buffer commits")
lmapCR("n", "fgB", ":Telescope git_branches", "Search branches")
lmapCR("n", "fgs", ":Telescope git_status", "Search git status")
lmapCR("n", "fgS", ":Telescope git_stash", "Search git stash")

-- <leader>a actions
lmapCR("n", "ac", ":ColorizerToggle", "colorizer")
lmapCR("n", "ae", ":CocCommand explorer", "explorer")
lmapCR("n", "an", ":set nonumber!", "line-numbers")
lmapCR("n", "ar", ":set norelativenumber!", "relative line nums")
lmapCR("n", "as", ':let @/ = ""', "remove search highlight")
lmapCR("n", "aS", ":CocCommand cSpell.toggleEnableSpellChecker", "toggle spellchecking")
lmapCR("n", "aM", ":SignatureToggleSigns", "toggle mark sings")
lmapCR("n", "at", ":FloatermToggle", "terminal")
lmapCR("n", "au", ":UndotreeToggle | UndotreeFocus", "Undotree")
lmapCR("n", "av", ":VCoolor", "vcoolor picker")
lmapCR("n", "ay", ':call SendViaOSC52(getreg("))', "remote yank")
lmapCR("n", "aw", "<Plug>(coc-codeaction-selected)w", "spell check word")

-- <leader>b buffers
lmapCR("n", "b1", "b1", "buffer 1")
lmapCR("n", "b2", "b2", "buffer 2")
lmapCR("n", "bf", ":bfirst", "first-buffer")
lmapCR("n", "bl", ":blast", "last-buffer")
lmapCR("n", "bo", ":Bdelete other", "close other buffers")
lmapCR("n", "bd", ":Bdelete menu", "close menu")
lmapCR("n", "bn", ":enew", "new buffer")
lmapCR("n", "bv", ":vsp", "new vertical split")
lmapCR("n", "bh", ":sp", "new horizontal split")
lmapCR("n", "bV", ":vnew", "new vertical buffer")
lmapCR("n", "bH", ":new", "new horizontal buffer")
lmapCR("n", "bw", ":Buffers", "fzf-buffer")
lmapCR("n", "bq", ":Bdelete this", "close-buffer")
lmapCR("n", "bQ", ":Bdelete! this", "close-buffer!")
lmapCR("n", "bs", ":BufferLinePick", "switch buffer")

-- <leader>S vim sessions
-- save

lmapCR("n", "Sss", ":call SaveVimSession(1)", "save 1")
lmapCR("n", "Ss1", ":call SaveVimSession(1)", "save 1")
lmapCR("n", "Ss2", ":call SaveVimSession(2)", "save 2")
lmapCR("n", "Ss3", ":call SaveVimSession(3)", "save 3")
lmapCR("n", "Ss4", ":call SaveVimSession(4)", "save 4")
lmapCR("n", "Ss5", ":call SaveVimSession(5)", "save 5")
lmapCR("n", "Ss6", ":call SaveVimSession(6)", "save 6")
lmapCR("n", "Ss7", ":call SaveVimSession(7)", "save 7")
lmapCR("n", "Ss8", ":call SaveVimSession(8)", "save 8")
lmapCR("n", "Ss9", ":call SaveVimSession(9)", "save 9")
lmapCR("n", "Ss0", ":call SaveVimSession(0)", "save 0")
-- load
lmapCR("n", "Sll", ":call LoadVimSession(1)", "load 1")
lmapCR("n", "Sl1", ":call LoadVimSession(1)", "load 1")
lmapCR("n", "Sl2", ":call LoadVimSession(2)", "load 2")
lmapCR("n", "Sl3", ":call LoadVimSession(3)", "load 3")
lmapCR("n", "Sl4", ":call LoadVimSession(4)", "load 4")
lmapCR("n", "Sl5", ":call LoadVimSession(5)", "load 5")
lmapCR("n", "Sl6", ":call LoadVimSession(6)", "load 6")
lmapCR("n", "Sl7", ":call LoadVimSession(7)", "load 7")
lmapCR("n", "Sl8", ":call LoadVimSession(8)", "load 8")
lmapCR("n", "Sl9", ":call LoadVimSession(9)", "load 9")
lmapCR("n", "Sl0", ":call LoadVimSession(0)", "load 0")

-- delete
lmapCR("n", "Sda", ":call DeleteAllVimSessions()", "delete all")
lmapCR("n", "Sd1", ":call DeleteVimSession(1)", "delete 1")
lmapCR("n", "Sd2", ":call DeleteVimSession(2)", "delete 2")
lmapCR("n", "Sd3", ":call DeleteVimSession(3)", "delete 3")
lmapCR("n", "Sd4", ":call DeleteVimSession(4)", "delete 4")
lmapCR("n", "Sd5", ":call DeleteVimSession(5)", "delete 5")
lmapCR("n", "Sd6", ":call DeleteVimSession(6)", "delete 6")
lmapCR("n", "Sd7", ":call DeleteVimSession(7)", "delete 7")
lmapCR("n", "Sd8", ":call DeleteVimSession(8)", "delete 8")
lmapCR("n", "Sd9", ":call DeleteVimSession(9)", "delete 9")
lmapCR("n", "Sd0", ":call DeleteVimSession(0)", "delete 0")

-- <leader>s search
lmapCR("n", "s/", ":History/", "history")
lmapCR("n", "s;", ":Commands", "commands")
lmapCR("n", "sa", ":Ag", "text Ag")
lmapCR("n", "sb", ":BLines", "current buffer")
lmapCR("n", "sB", ":Buffers", "open buffers")
lmapCR("n", "sc", ":Commits", "commits")
lmapCR("n", "sC", ":BCommits", "buffer commits")
lmapCR("n", "sf", ":Files", "files")
lmapCR("n", "sg", ":GFiles", "git files")
lmapCR("n", "sG", ":GFiles?", "modified git files")
lmapCR("n", "sh", ":History", "file history")
lmapCR("n", "sH", ":History:", "command history")
lmapCR("n", "sl", ":Lines", "lines")
lmapCR("n", "sm", ":Marks", "marks")
lmapCR("n", "sM", ":Maps", "normal maps")
lmapCR("n", "sp", ":Helptags", "help tags")
lmapCR("n", "sP", ":Tags", "project tags")
lmapCR("n", "ss", ":Snippets", "snippets")
lmapCR("n", "sS", ":Colors", "color schemes")
lmapCR("n", "st", ":Rg", "text Rg")
lmapCR("n", "sT", ":BTags", "buffer tags")
lmapCR("n", "sw", ":Windows", "search windows")
lmapCR("n", "sy", ":Filetypes", "file types")
lmapCR("n", "sz", ":FZF", "FZF")

-- <leader>g git

lmapCR("n", "ga", ":Git add .", "add all")
lmapCR("n", "gA", ":Git add %", "add current")
lmapCR("n", "gb", ":Git blame", "blame")
lmapCR("n", "gB", ":GBrowse", "browse")
lmapCR("n", "gc", ":Git commit", "commit")
lmapCR("n", "gg", ":GGrep", "git grep")
lmapCR("n", "gG", ":Gstatus", "status")
lmapCR("n", "gh", ":GitGutterLineHighlightsToggle", "highlight hunks")
lmapCR("n", "gH", "<Plug>(GitGutterPreviewHunk)", "preview hunk")
lmapCR("n", "gl", ":Git log", "log")
lmapCR("n", "gM", ":!meld . &", "open meld mergetool")
lmapCR("n", "gP", ":Git push", "push")
lmapCR("n", "gp", ":Git pull", "pull")
lmapCR("n", "gr", ":GRemove", "remove")
lmapCR("n", "gs", "<Plug>(GitGutterStageHunk)", "stage hunk")
lmapCR("n", "gt", ":Gitsigns toggle_current_line_blame", "toggle inline blame")
lmapCR("n", "gu", "<Plug>(GitGutterUndoHunk)", "undo hunk")
lmapCR("n", "gv", ":GV", "view commits")
lmapCR("n", "gV", ":GV!", "view buffer commits")
lmapCR("n", "g>", ":diffget //2", "diffget from left")
lmapCR("n", "g<", ":diffget //3", "diffget from right")

-- gd git diff
lmapCR("n", "gdd", ":Git diff", "diff")
lmapCR("n", "gdD", ":Gdiffsplit!", "diff split")
lmapCR("n", "gdH", ":diffget //2", "diffget from right")
lmapCR("n", "gdL", ":diffget //3", "diffget from left")
lmapCR("n", "gdJ", "]c", "prev change")
lmapCR("n", "gdK", "[c", "next change")
lmapCR("n", "gdm", ":!meld . &", "open meld mergetool")

-- <leader>T tabularize
lmapCR("n", "T=", ":Tabularize /=", "=")
lmapCR("n", "T:", ":Tabularize /:\zs", ":")
lmapCR("n", "T,", ":Tabularize /,\zs", ",")
lmapCR("n", "T ", ":Tabularize / \zs", ",")

-- <leader>t terminal
lmapCR("n", "tg", ":FloatermNew lazygit", "git")
lmapCR("n", "ts", ":call FloatermOpenSo()", "StackOverflow")
lmapCR("n", "tr", ":FloatermNew ranger", "ranger")
lmapCR("n", "tt", ":FloatermNew", "terminal")
lmapCR("n", "tc", ":call FloatermOpenCheat()", "cheat")
lmapCR("n", "tw", ":call FloatermOpenVimwiki()", "vimwiki")

-- <leader>w VimWiki
lmapCR("n", "ws", ':call jobstart(\'sh -c "cd ~/vimwiki && git push"\')', "Save wiki")

-- <leader>l LSP
--      \ 'name' : '+lsp',
lmapCR("n", "lf", ":Format", "Format")
lmapCR("n", "lv", ":Vista!!", "tag viewer")

-- lmapCR("n", "la", "<Plug>(coc-codeaction-line)", "line action")
-- lmapCR("n", "lA", "<Plug>(coc-codeaction)", "code action")
-- lmapCR("n", "lb", ":CocNext", "next action")
-- lmapCR("n", "lB", ":CocPrev", "prev action")
-- lmapCR("n", "lc", ":CocList commands", "commands")
-- lmapCR("n", "ld", "<Plug>(coc-definition)", "definition")
-- lmapCR("n", "lD", "<Plug>(coc-declaration)", "declaration")
-- lmapCR("n", "le", ":CocList extensions", "extensions")
-- lmapCR("n", "lf", "<Plug>(coc-format-selected)", "format selected")
-- lmapCR("n", "lF", "<Plug>(coc-format)", "format")
-- lmapCR("n", "lh", "<Plug>(coc-float-hide)", "hide")
-- lmapCR("n", "li", "<Plug>(coc-implementation)", "implementation")
-- lmapCR("n", "lI", ":CocList diagnostics", "diagnostics")
-- lmapCR("n", "lj", "<Plug>(coc-float-jump)", "float jump")
-- lmapCR("n", "ll", "<Plug>(coc-codelens-action)", "code lens")
-- lmapCR("n", "ln", "<Plug>(coc-diagnostic-next)", "next diagnostic")
-- lmapCR("n", "lN", "<Plug>(coc-diagnostic-next-error)", "next error")
-- lmapCR("n", "lo", ':call CocAction("runCommand",        "editor.action.organizeImport")', "organize imports")
-- lmapCR("n", "lO", ":CocList outline", "outline")
-- lmapCR("n", "lp", "<Plug>(coc-diagnostic-prev)", "prev diagnostic")
-- lmapCR("n", "lP", "<Plug>(coc-diagnostic-prev-error)", "prev error")
-- lmapCR("n", "lq", "<Plug>(coc-fix-current)", "quickfix")
-- lmapCR("n", "lr", "<Plug>(coc-rename)", "rename")
-- lmapCR("n", "lR", "<Plug>(coc-references)", "references")
-- lmapCR("n", "lt", "<Plug>(coc-type-definition)", "type definition")
-- lmapCR("n", "lu", ":CocListResume", "resume list")
-- lmapCR("n", "lU", ":CocUpdate", "update CoC")
-- lmapCR("n", "lz", ":CocDisable", "disable CoC")
-- lmapCR("n", "lZ", ":CocEnable", "enable CoC")
