require("flutter-tools").setup {
fvm = true,
}
-- Automatically run dartfix on save for Dart files
vim.cmd('autocmd BufWritePost *.dart :!fvm dart fix % --apply')

