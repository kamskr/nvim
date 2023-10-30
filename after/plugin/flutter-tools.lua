require("flutter-tools").setup {
    fvm = true,
    widget_guides = {
        enabled = true,
    },
    debugger = { -- integrate with nvim dap + install dart code debugger
        enabled = false,
        run_via_dap = false, -- use dap instead of a plenary job to run flutter apps
    },
    lsp = {
        color = { -- show the derived colours for dart variables
        enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
        background = false, -- highlight the background
        background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
        foreground = false, -- highlight the foreground
        virtual_text = true, -- show the highlight using virtual text
        virtual_text_str = "■", -- the virtual text character to highlight
    },
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
