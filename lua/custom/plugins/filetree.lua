-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function()
    -- if you want icons for diagnostic errors, you'll need to define them somewhere:
    vim.fn.sign_define("diagnosticsignerror",
      { text = " ", texthl = "diagnosticsignerror" })
    vim.fn.sign_define("diagnosticsignwarn",
      { text = " ", texthl = "diagnosticsignwarn" })
    vim.fn.sign_define("diagnosticsigninfo",
      { text = " ", texthl = "diagnosticsigninfo" })
    vim.fn.sign_define("diagnosticsignhint",
      { text = "󰌵", texthl = "diagnosticsignhint" })

    require("neo-tree").setup({
        buffers = {
          follow_current_file = {
            enabled = true, -- this will find and focus the file in the active buffer every time
            --              -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:neotree reveal`
          },
        },
      })

      vim.cmd([[nnoremap \ :neotree reveal<cr>]])
    end
}
