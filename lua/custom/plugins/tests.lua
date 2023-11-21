return {
  'vim-test/vim-test',
  config = function()
    vim.api.nvim_set_keymap('n', '<leader>tr', [[:TestNearest<CR>]],
      { noremap = true, silent = true, desc = "Run nearest test(s)" })
    vim.api.nvim_set_keymap('n', '<leader>tf', [[:TestFile<CR>]],
      { noremap = true, silent = true, desc = "Run all tests in current file" })
    vim.api.nvim_set_keymap('n', '<leader>ta', [[:TestSuite<CR>]],
      { noremap = true, silent = true, desc = "Run all tests in the suite" })
    vim.api.nvim_set_keymap('n', '<leader>tl', [[:TestLast<CR>]],
      { noremap = true, silent = true, desc = "Run last test" })
    vim.api.nvim_set_keymap('n', '<leader>tv', [[:TestVisit<CR>]],
      { noremap = true, silent = true, desc = "Visits the test file from which you last run your tests" })
  end
}
