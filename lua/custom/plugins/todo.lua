return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('todo-comments').setup {
      highlight = {
        -- vimgrep regex, supporting the pattern TODO(name):
        pattern = [[.*<((KEYWORDS)%(\(.{-1,}\))?):]],
      },
      search = {
        -- ripgrep regex, supporting the pattern TODO(name):
        pattern = [[\b(KEYWORDS)(\(\w*\))*:]],
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
