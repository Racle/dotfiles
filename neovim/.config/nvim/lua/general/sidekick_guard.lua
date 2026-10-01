--- Guards for sidekick.nvim agent windows:
--- 1. keep non-agent buffers (e.g. `gd` jumps) out of the agent window
--- Note: the floating sidekick layout is skipped (only split windows are guarded).
--- 2. make mouse selection/copy inside the agent terminal work (OSC52 forward)
local M = {}

local FT = "sidekick_terminal"
local busy = false

local function is_agent_buf(buf)
  if not vim.api.nvim_buf_is_valid(buf) then
    return false
  end
  if vim.bo[buf].filetype == FT then
    return true
  end
  return vim.bo[buf].buftype == "terminal" and vim.b[buf].sidekick_cli ~= nil
end

local function is_floating(win)
  return vim.api.nvim_win_get_config(win).relative ~= ""
end

local function is_sidekick_win(win)
  return vim.w[win].sidekick_guard_buf ~= nil or vim.w[win].sidekick_session_id ~= nil
end

local function find_target(from)
  local prev = vim.fn.win_getid(vim.fn.winnr("#"))
  if prev ~= 0 and prev ~= from and vim.api.nvim_win_is_valid(prev) and not is_sidekick_win(prev) and not is_floating(prev) then
    return prev
  end
  for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if w ~= from and not is_floating(w) and not is_sidekick_win(w) and vim.bo[vim.api.nvim_win_get_buf(w)].buftype == "" then
      return w
    end
  end
end

local MAX_PAYLOAD = 1024 * 1024 -- base64 chars

local function forward_osc52(seq)
  -- only clipboard writes; ignore queries ('?') and empty payloads
  local payload = seq:match("^\27%]52;[^;]*;(.*)$")
  if not payload or payload == "" or payload == "?" or #payload > MAX_PAYLOAD then
    return
  end
  local out = seq:gsub("[\7\27\\]+$", "") .. "\7"
  if vim.api.nvim_ui_send then
    vim.api.nvim_ui_send(out)
  else
    io.stdout:write(out)
    io.stdout:flush()
  end
end

function M.setup()
  local group = vim.api.nvim_create_augroup("SidekickGuard", {clear = true})

  -- remember agent buffer per window
  vim.api.nvim_create_autocmd(
    {"BufWinEnter", "FileType"},
    {
      group = group,
      callback = function(ev)
        local win = vim.api.nvim_get_current_win()
        if is_floating(win) or vim.api.nvim_win_get_buf(win) ~= ev.buf then
          return
        end
        if vim.b[ev.buf].sidekick_cli ~= nil then
          vim.w[win].sidekick_guard_buf = ev.buf
        end
      end
    }
  )

  -- new windows (generic splits) must not inherit sidekick window vars;
  -- sidekick sets its own vars after creating its window
  vim.api.nvim_create_autocmd(
    "WinNew",
    {
      group = group,
      callback = function()
        local win = vim.api.nvim_get_current_win()
        if not is_floating(win) then
          vim.w[win].sidekick_guard_buf = nil
          vim.w[win].sidekick_session_id = nil
        end
      end
    }
  )

  -- redirect foreign buffers out of sidekick windows
  vim.api.nvim_create_autocmd(
    "BufWinEnter",
    {
      group = group,
      callback = function(ev)
        if busy then
          return
        end
        local win = vim.api.nvim_get_current_win()
        local buf = ev.buf
        if is_floating(win) or not is_sidekick_win(win) or is_agent_buf(buf) then
          return
        end
        local agent = vim.w[win].sidekick_guard_buf
        if not agent or not vim.api.nvim_buf_is_valid(agent) or agent == buf then
          return
        end
        local cursor = vim.api.nvim_win_get_cursor(win)
        vim.schedule(
          function()
            if busy or not vim.api.nvim_win_is_valid(win) or not vim.api.nvim_buf_is_valid(buf) then
              return
            end
            if vim.api.nvim_win_get_buf(win) ~= buf then
              return
            end
            busy = true
            local ok, err =
              pcall(
              function()
                vim.api.nvim_win_set_buf(win, agent)
                local target = find_target(win)
                if not target then
                  vim.api.nvim_set_current_win(win)
                  vim.cmd("leftabove vsplit")
                  target = vim.api.nvim_get_current_win()
                  vim.w[target].sidekick_guard_buf = nil
                  vim.w[target].sidekick_session_id = nil
                end
                vim.api.nvim_win_set_buf(target, buf)
                vim.api.nvim_set_current_win(target)
                local lines = vim.api.nvim_buf_line_count(buf)
                pcall(vim.api.nvim_win_set_cursor, target, {math.min(cursor[1], lines), cursor[2]})
              end
            )
            busy = false
            if not ok then
              vim.notify("SidekickGuard: " .. tostring(err), vim.log.levels.WARN)
            end
          end
        )
      end
    }
  )

  -- clicks in the agent terminal: enter terminal mode so drags go to the agent
  vim.api.nvim_create_autocmd(
    "FileType",
    {
      group = group,
      pattern = FT,
      callback = function(ev)
        if vim.bo[ev.buf].buftype == "terminal" and vim.b[ev.buf].sidekick_cli ~= nil then
          vim.keymap.set("n", "<LeftMouse>", "<LeftMouse><Cmd>startinsert<CR>", {buffer = ev.buf, silent = true, desc = "Click + enter terminal mode"})
        end
      end
    }
  )

  -- forward OSC 52 clipboard writes from the agent to the outer terminal
  vim.api.nvim_create_autocmd(
    "TermRequest",
    {
      group = group,
      callback = function(ev)
        if vim.b[ev.buf].sidekick_cli == nil and vim.bo[ev.buf].filetype ~= FT then
          return
        end
        local seq = type(ev.data) == "table" and ev.data.sequence or nil
        if type(seq) == "string" then
          forward_osc52(seq)
        end
      end
    }
  )
end

return M
