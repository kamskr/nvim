return {
  'github/copilot.vim',
  config = function()
    require('copilot').setup()

    vim.keymap.set('i', '<C-j>', 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false,
    })
    vim.g.copilot_no_tab_map = true

    vim.keymap.set('i', '<C-k>', function()
      return vim.fn['copilot#Clear']()
    end, { expr = true })

    vim.keymap.set('i', '<C-l>', function()
      return vim.fn['copilot#Next']()
    end, { expr = true })
  end,
}

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
-- return {
--   'supermaven-inc/supermaven-nvim',
--   config = function()
--     require('supermaven-nvim').setup {
--       keymaps = {
--         accept_suggestion = '<C-j>',
--         clear_suggestion = '<C-l>',
--         accept_word = '<C-k>',
--       },
--     }
--   end,
-- }
