return {
  {
    'lmilojevicc/herdr-splits.nvim',
    cond = vim.env.HERDR_ENV == '1',
    event = 'VeryLazy',
    build = function()
      require('herdr-splits').sync_herdr()
    end,
    config = function()
      require('herdr-splits').setup {
        auto_sync_herdr = true,
      }
    end,
    keys = {
      { '<c-h>', function() require('herdr-splits').move_cursor_left() end, desc = 'Navigate left' },
      { '<c-j>', function() require('herdr-splits').move_cursor_down() end, desc = 'Navigate down' },
      { '<c-k>', function() require('herdr-splits').move_cursor_up() end, desc = 'Navigate up' },
      { '<c-l>', function() require('herdr-splits').move_cursor_right() end, desc = 'Navigate right' },
      { '<m-h>', function() require('herdr-splits').resize_left() end, desc = 'Resize left' },
      { '<m-j>', function() require('herdr-splits').resize_down() end, desc = 'Resize down' },
      { '<m-k>', function() require('herdr-splits').resize_up() end, desc = 'Resize up' },
      { '<m-l>', function() require('herdr-splits').resize_right() end, desc = 'Resize right' },
    },
  },

  {
    'christoomey/vim-tmux-navigator',
    cond = vim.env.HERDR_ENV ~= '1',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
      'TmuxNavigatorProcessList',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
    config = function() end,
  },
}
