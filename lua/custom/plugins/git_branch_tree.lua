return {
  'junegunn/gv.vim',

  config = function()
    vim.keymap.set("n", "<leader>gt", vim.cmd.GV, { desc = "Open git tree" })
  end
}
