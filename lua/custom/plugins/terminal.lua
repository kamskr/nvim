return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup {
      open_mapping = [[<c-/>]],
      direction = 'float',
    }

    vim.cmd([[nnoremap <silent><c-/> <Cmd>exe v:count1 . "ToggleTerm"<CR>]])
  end,
}
