return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('todo-comments').setup {
      highlight = {
        pattern = [[.*<(KEYWORDS)(\([^\)]*\))?:]],
      },
      search = {
        pattern = [[\b(KEYWORDS)(\([^\)]*\))?:]],
      },
    }
    vim.api.nvim_set_keymap(
      'n',
      '<leader>std',
      '<cmd>TodoTrouble<CR>',
      { desc = 'Open todos in quickfix list' }
    )
  end,
}
