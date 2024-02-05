return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- your custom config
    require('trouble').setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }

    -- Keybindings
    vim.keymap.set('n', '<leader>dl', function()
      require('trouble').toggle 'workspace_diagnostics'
    end)
    vim.keymap.set(
      'n',
      '<leader>e',
      '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',
      {
        desc = 'Open Diagnostic Popup',
      }
    )
    vim.keymap.set('n', 'gR', function()
      require('trouble').toggle 'lsp_references'
    end)
  end,
}
