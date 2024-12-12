-- return { 'github/copilot.vim' }
return {
  'supermaven-inc/supermaven-nvim',
  config = function()
    require('supermaven-nvim').setup {
      keymaps = {
        accept_suggestion = '<C-j>',
        clear_suggestion = '<C-l>',
        accept_word = '<C-k>',
      },
    }
  end,
}
