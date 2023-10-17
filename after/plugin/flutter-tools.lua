require("flutter-tools").setup {
    fvm = true,
    widget_guides = {
        enabled = false,
    },
}
-- Automatically run dartfix on save for Dart files
-- vim.cmd('autocmd BufWritePost *.dart :!fvm dart fix % --apply')
vim.api.nvim_set_keymap('n', '<leader>df', ':!fvm dart fix % --apply<CR>', { noremap = true, silent = true })

function formatDartBuffer()
    -- Check if the current buffer's filetype is "dart"
    if vim.bo.filetype == 'dart' then
        -- Save the current cursor position
        local cursor_position = vim.fn.getpos('.')

        -- Move to the beginning of the buffer and format to the end
        vim.cmd([[1]])
        vim.cmd([[execute 'normal! ggVGgq']])

        -- Restore the cursor position
        vim.fn.setpos('.', cursor_position)
    end
end

-- Automatically format Dart files before saving
vim.api.nvim_command([[autocmd BufWritePre *.dart lua formatDartBuffer()]])
