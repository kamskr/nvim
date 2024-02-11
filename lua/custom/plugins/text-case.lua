return {
  'johmsalas/text-case.nvim',
  config = function()
    require('textcase').setup {}
    require('telescope').load_extension 'textcase'
    vim.api.nvim_set_keymap(
      'n',
      '<leader>cs',
      '<cmd>TextCaseOpenTelescope<CR>',
      { desc = '[C]hange ca[S]e with telescope' }
    )
  end,
}
