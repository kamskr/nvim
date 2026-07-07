local function herdr_nvim_server()
  if not vim.env.HERDR_PANE_ID then
    return nil
  end

  local pane_id = vim.env.HERDR_PANE_ID:gsub('[^%w_.-]', '_')
  return ('/tmp/herdr-nvim-%s-%s.sock'):format(vim.env.USER or 'user', pane_id)
end

local server = herdr_nvim_server()
if server and vim.v.servername ~= server then
  pcall(vim.fn.serverstart, server)
end

function _G.HerdrNavigate(nvim_direction)
  local win = vim.api.nvim_get_current_win()
  vim.cmd.wincmd(nvim_direction)
  if vim.api.nvim_get_current_win() ~= win then
    return 'moved'
  end

  return 'edge'
end

local function navigate(nvim_direction, herdr_direction, tmux_command)
  if _G.HerdrNavigate(nvim_direction) == 'moved' then
    return
  end

  if vim.env.HERDR_PANE_ID then
    vim.fn.jobstart({ 'herdr', 'pane', 'focus', '--pane', vim.env.HERDR_PANE_ID, '--direction', herdr_direction }, { detach = true })
  else
    vim.cmd[tmux_command]()
  end
end

return {
  'christoomey/vim-tmux-navigator',
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
  cmd = {
    'TmuxNavigateLeft',
    'TmuxNavigateDown',
    'TmuxNavigateUp',
    'TmuxNavigateRight',
    'TmuxNavigatePrevious',
    'TmuxNavigatorProcessList',
  },
  keys = {
    { '<c-h>', function() navigate('h', 'left', 'TmuxNavigateLeft') end },
    { '<c-j>', function() navigate('j', 'down', 'TmuxNavigateDown') end },
    { '<c-k>', function() navigate('k', 'up', 'TmuxNavigateUp') end },
    { '<c-l>', function() navigate('l', 'right', 'TmuxNavigateRight') end },
    { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
  },
  config = function() end,
}
