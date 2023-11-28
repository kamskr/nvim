return {
  "johmsalas/text-case.nvim",
  config = function()
    require('textcase').setup {}
    require('telescope').load_extension('textcase')
    vim.api.nvim_set_keymap('n', '<leader>cc', '<cmd>TextCaseOpenTelescope<CR>', { desc = "Change case with telescope" })
  end
}
