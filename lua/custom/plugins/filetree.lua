-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- If you want icons for diagnostic errors, you'll need to define them somewhere:
    vim.fn.sign_define("DiagnosticSignError",
      { text = " ", texthl = "DiagnosticSignError" })
    vim.fn.sign_define("DiagnosticSignWarn",
      { text = " ", texthl = "DiagnosticSignWarn" })
    vim.fn.sign_define("DiagnosticSignInfo",
      { text = " ", texthl = "DiagnosticSignInfo" })
    vim.fn.sign_define("DiagnosticSignHint",
      { text = " ", texthl = "DiagnosticSignHint" })

    require("neo-tree").setup({
      filesystem = {
        follow_current_file = {
          enabled = true,          -- This will find and focus the file in the active buffer every time
          --               -- the current file is changed while the tree is open.
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        filtered_items = {
          hide_by_name = {
            --"node_modules"
            "pubspec.lock"
          },
          hide_by_pattern = { -- uses glob style patterns
            --"*.meta",
            --"*/src/*/tsconfig.json",
            "*/**/*.g.dart",
            "*/**/*.freezed.dart",
          },
        },
      },
      buffers = {
        follow_current_file = {
          enabled = true,          -- This will find and focus the file in the active buffer every time
          --              -- the current file is changed while the tree is open.
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        group_empty_dirs = true,   -- when true, empty folders will be grouped together
      },
      default_component_configs = {
        git_status = {
          symbols = {
            -- Change type
            added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted   = "✖", -- this can only be used in the git_status source
            renamed   = "R", -- this can only be used in the git_status source
            -- Status type
            untracked = "U",
            ignored   = "I",
            unstaged  = "U",
            staged    = "S",
            conflict  = "C!",
          }
        },
      },
    })

    vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
    vim.api.nvim_set_keymap('n', '<C-b>', [[:Neotree<CR>]], { noremap = true, silent = true, desc = "Open file tree" })
  end
}
