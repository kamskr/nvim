require("flutter-tools").setup {
fvm = true,
}
-- Automatically run dartfix on save for Dart files
-- vim.cmd('autocmd BufWritePost *.dart :!fvm dart fix % --apply')
vim.api.nvim_set_keymap('n', '<leader>df', ':!fvm dart fix % --apply<CR>', { noremap = true, silent = true })

