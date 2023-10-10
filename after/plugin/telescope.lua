local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

vim.keymap.set("n", "<leader>tb", builtin.buffers, {})
vim.keymap.set("n", "<leader>to", builtin.oldfiles, {})
vim.keymap.set("n", "<leader>tlb", function()
	builtin.git_branches({ show_remote_tracking_branches = false })
end, {})

vim.keymap.set("n", "<leader>tlrb", builtin.git_branches, {})
vim.keymap.set("n", "<leader>tgg", require("telescope").extensions.live_grep_args.live_grep_args)
vim.keymap.set("n", "<leader>th", builtin.help_tags, {})
vim.keymap.set("n", "<leader>tc", builtin.commands, {})

vim.keymap.set("n", "<leader>ts", builtin.lsp_document_symbols, {})

require("telescope").load_extension("fzy_native")
require("telescope").load_extension("live_grep_args")
require("telescope").load_extension("ui-select")
