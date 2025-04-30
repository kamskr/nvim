-- return {
--   'github/copilot.vim',
--   config = function()
--     require('copilot').setup()
--
--     vim.keymap.set('i', '<C-j>', 'copilot#Accept("\\<CR>")', {
--       expr = true,
--       replace_keycodes = false,
--     })
--     vim.g.copilot_no_tab_map = true
--
--     vim.keymap.set('i', '<C-k>', function()
--       return vim.fn['copilot#Clear']()
--     end, { expr = true })
--
--     vim.keymap.set('i', '<C-l>', function()
--       return vim.fn['copilot#Next']()
--     end, { expr = true })
--   end,
-- }

-- return {
--   'Exafunction/codeium.vim',
--   event = 'BufEnter',
--   config = function()
--     require('codeium').setup()
--
--     vim.keymap.set('i', '<C-j>', function()
--       return vim.fn['codeium#Accept']()
--     end, { expr = true })
--     vim.keymap.set('i', '<C-l>', function()
--       return vim.fn['codeium#Clear']()
--     end, { expr = true })
--     vim.keymap.set('i', '<C-k>', function()
--       return vim.fn['codeium#AcceptWord']()
--     end, { expr = true })
--   end,
-- }
return {
  'supermaven-inc/supermaven-nvim',
  config = function()
    require('supermaven-nvim').setup {
      keymaps = {
        accept_suggestion = '<C-j>',
        clear_suggestion = '<C-l>',
        accept_word = '<C-k>',
      },
    }
  end,
}
--
-- return {
--   'Exafunction/windsurf.nvim',
--   requires = {
--     'nvim-lua/plenary.nvim',
--     'hrsh7th/nvim-cmp',
--   },
--   config = function()
--     require('codeium').setup {
--       -- Optionally disable cmp source if using virtual text only
--       enable_cmp_source = true,
--       virtual_text = {
--         enabled = true,
--
--         -- These are the defaults
--
--         -- Set to true if you never want completions to be shown automatically.
--         manual = false,
--         -- A mapping of filetype to true or false, to enable virtual text.
--         filetypes = {},
--         -- Whether to enable virtual text of not for filetypes not specifically listed above.
--         default_filetype_enabled = true,
--         -- How long to wait (in ms) before requesting completions after typing stops.
--         idle_delay = 75,
--         -- Priority of the virtual text. This usually ensures that the completions appear on top of
--         -- other plugins that also add virtual text, such as LSP inlay hints, but can be modified if
--         -- desired.
--         virtual_text_priority = 65535,
--         -- Set to false to disable all key bindings for managing completions.
--         map_keys = true,
--         -- The key to press when hitting the accept keybinding but no completion is showing.
--         -- Defaults to \t normally or <c-n> when a popup is showing.
--         accept_fallback = nil,
--         -- Key bindings for managing completions in virtual text mode.
--         key_bindings = {
--           -- Accept the current completion.
--           accept = '<C-j>',
--           -- Accept the next word.
--           accept_word = '<C-k>',
--           -- Accept the next line.
--           accept_line = false,
--           -- Clear the virtual text.
--           clear = false,
--           -- Cycle to the next completion.
--           next = '<C-.>',
--           -- Cycle to the previous completion.
--           prev = '<C-,>',
--         },
--       },
--     }
--   end,
-- }
