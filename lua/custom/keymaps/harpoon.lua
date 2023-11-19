local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file, { desc = 'Add file to harpoon' })
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-H>",  ui.nav_prev)
vim.keymap.set("n", "<C-L>",  ui.nav_next)

