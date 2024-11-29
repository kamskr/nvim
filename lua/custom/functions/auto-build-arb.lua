# Run fvm flutter gen-l10 when .arb file is saved

vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = '*.arb',
    callback = function()
        vim.cmd('!fvm flutter gen-l10n')
    end,
})

