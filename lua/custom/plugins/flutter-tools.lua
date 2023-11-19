return {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function()
        require("flutter-tools").setup {
            fvm = true,
            widget_guides = {
                enabled = true,
            },
            debugger = {     -- integrate with nvim dap + install dart code debugger
                enabled = true,
                run_via_dap = true, -- use dap instead of a plenary job to run flutter apps
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
    end

}
