require('lualine').setup {
    options = {
        theme = 'material',
        icons_enabled = true,
    },
    sections = {
        lualine_a = {
            'filename',
            path = 1,
        }
    }
}
