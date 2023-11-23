return {
  'andythigpen/nvim-coverage',
  config = function()
    require('coverage').setup()

    vim.api.nvim_set_keymap('n', '<leader>tc', [[:Coverage<CR>:CoverageSummary<CR>]],
      { noremap = true, silent = true, desc = "Show [T]est [C]overage" })
  end
}
