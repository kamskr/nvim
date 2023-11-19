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

    vim.keymap.set("n", "<leader>tr", function()
      require("neotest").run.run()
    end, { desc = 'Run closest  test(s)' })

    vim.keymap.set("n", "<leader>ta", function()
      require("neotest").run.run({ suite = true })
    end, { desc = 'Run all  tests' })

    vim.keymap.set("n", "<leader>to", function()
      require("neotest").output.open({ enter = true })
    end, { desc = 'Display flutter test output' })

    vim.keymap.set("n", "<leader>tp", function()
      require("neotest").output_panel.toggle()
    end, { desc = 'Open test output panel' })


    vim.keymap.set("n", "<leader>tw", function()
      require("neotest").watch.toggle()
    end, { desc = 'Run test with watch' })

    vim.keymap.set("n", "<leader>ts", function()
      require("neotest").summary.toggle()
    end, { desc = 'Open tests summary' })
  end
}
