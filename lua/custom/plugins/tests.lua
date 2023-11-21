return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "sidlatau/neotest-dart",
  },
  opts = function()
    return {
      -- your neotest config here
      adapters = {
        require('neotest-dart') {
          command = 'fvm flutter', -- Command being used to run tests. Defaults to `flutter`
          -- Change it to `fvm flutter` if using FVM
          -- change it to `dart` for Dart only tests
          use_lsp = true, -- When set Flutter outline information is used when constructing test name.
          -- Useful when using custom test names with @isTest annotation
          custom_test_method_names = {},
        }
      },
    }
  end,
  config = function(_, opts)
    require("neotest").setup(opts)

    vim.keymap.set("n", "<leader>tr", function()
      require("neotest").run.run()
    end, { desc = "Run closest test" })

    vim.keymap.set("n", "<leader>td", function()
      require("neotest").run.run({ strategy = "dap" })
    end, { desc = "Debug closest test" })

    vim.keymap.set("n", "<leader>ta", function()
      require("neotest").run.run({ suite = true })
    end, { desc = "Run all tests" })

    vim.keymap.set("n", "<leader>to", function()
      require("neotest").output.open({ enter = true })
    end, { desc = "Open test output" })

    vim.keymap.set("n", "<leader>top", function()
      require("neotest").output_panel.toggle()
    end, { desc = "Toggle test output panel" })


    vim.keymap.set("n", "<leader>tw", function()
      require("neotest").watch.toggle()
    end, { desc = "Toggle test watcher" })

    vim.keymap.set("n", "<leader>ts", function()
      require("neotest").summary.toggle()
    end, { desc = "Toggle test summary" })
  end,
}
