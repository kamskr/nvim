return {
  {
    'marko-cerovac/material.nvim',
    config = function()
      vim.cmd('colorscheme material')
    end
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "storm",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function(_, opts)
      local tokyonight = require "tokyonight"
      tokyonight.setup(opts)
      tokyonight.load()
    end,
  },
}
