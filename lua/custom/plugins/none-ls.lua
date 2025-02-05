return {
  'nvimtools/none-ls.nvim', -- null-ls.nvim renamed
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local null_ls = require 'null-ls'
    -- local flutter_bloc_actions = require 'flutter-bloc.code_action'

    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.prettier,
        -- null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.completion.spell,
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.code_actions.refactoring,
        -- {
        --   name = 'flutter-bloc',
        --   method = null_ls.methods.CODE_ACTION,
        --   filetypes = { 'dart' }, -- Ensure this matches the filetypes you need
        --   generator = {
        --     fn = function(params)
        --       -- Call the flutter-bloc action and return its results
        --       return flutter_bloc_actions(params)
        --     end,
        --   },
        -- },
      },
      debug = true, -- Enable for debugging
    }
  end,
}
