require('neotest').setup({
    adapters = {
        require('neotest-dart') {
            command = 'fvm flutter', -- Command being used to run tests. Defaults to `flutter`
            -- Change it to `fvm flutter` if using FVM
            -- change it to `dart` for Dart only tests
            use_lsp = true,      -- When set Flutter outline information is used when constructing test name.
            -- Useful when using custom test names with @isTest annotation
            custom_test_method_names = {},
        }
    }
});

vim.keymap.set("n", "<leader>ftr", function()
    require("neotest").run.run()
end)

vim.keymap.set("n", "<leader>fta", function()
    require("neotest").run.run({ suite = true })
end)

vim.keymap.set("n", "<leader>fto", function()
    require("neotest").output.open({ enter = true })
end)

vim.keymap.set("n", "<leader>ftop", function()
    require("neotest").output_panel.toggle()
end)


vim.keymap.set("n", "<leader>ftw", function()
    require("neotest").watch.toggle()
end)

vim.keymap.set("n", "<leader>fts", function()
   require("neotest").summary.toggle()
end)
