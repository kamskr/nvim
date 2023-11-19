return {
  'nvim-neotest/neotest',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    'sidlatau/neotest-dart',
  },
  config = function()
    require('neotest').setup({
      adapters = {
        require('neotest-dart') {
          command = 'fvm flutter', -- Command being used to run tests. Defaults to `flutter`
          use_lsp = true,          -- When set Flutter outline information is used when constructing test name.
          custom_test_method_names = {},
        },
      },
    })
  end
}
