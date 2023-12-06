return {
  'charludo/projectmgr.nvim',
  lazy = false, -- important!
  config = function()
    require("projectmgr").setup({
      session = { enabled = false, file = "Session.vim" },

    })
    vim.api.nvim_set_keymap('n', '<C-b>', [[:ProjectMgr<CR>]],
      { noremap = true, silent = true, desc = "Open project manager" })
  end,
}
