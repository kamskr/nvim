-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- Remap for dealing with word wrap
vim.keymap.set(
  'n',
  'k',
  "v:count == 0 ? 'gk' : 'k'",
  { expr = true, silent = true }
)
vim.keymap.set(
  'n',
  'j',
  "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true }
)

-- Diagnostic keymaps
vim.keymap.set(
  'n',
  '[d',
  vim.diagnostic.goto_prev,
  { desc = 'Go to previous diagnostic message' }
)
vim.keymap.set(
  'n',
  ']d',
  vim.diagnostic.goto_next,
  { desc = 'Go to next diagnostic message' }
)
vim.keymap.set(
  'n',
  '<leader>e',
  vim.diagnostic.open_float,
  { desc = 'Open floating diagnostic message' }
)
-- vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group =
  vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- greatest remap ever
vim.keymap.set('x', '<leader>p', [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])

vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>w', '<cmd>noautocmd w<CR>', { desc = 'Save without formatting' })

vim.keymap.set('n', '<leader>j', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>cprev<CR>zz')
-- vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
-- vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

vim.api.nvim_set_keymap(
  'n',
  '<leader>ss',
  [[:set invspell<CR>]],
  { desc = 'Toggle spell checking' }
)

-- GIT
vim.api.nvim_set_keymap(
  'n',
  '<leader>gs',
  [[:Git<CR>]],
  { noremap = true, silent = true, desc = 'Open fugitive status' }
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>si',
  [[:Telescope git_status<CR>]],
  { noremap = true, silent = true, desc = 'Search git status with telescope' }
)
vim.api.nvim_set_keymap(
  'n',
  'gs',
  [[:diffget //2<CR>]],
  { noremap = true, silent = true, desc = 'Git conflict get left change' }
)
vim.api.nvim_set_keymap(
  'n',
  'gk',
  [[:diffget //3<CR>]],
  { noremap = true, silent = true, desc = 'Git conflict get right change' }
)

vim.api.nvim_set_keymap(
  'n',
  '<leader>gh',
  [[:vertical Git log -p -- %<CR>]],
  { noremap = true, silent = true, desc = 'Git open file history' }
)

-- Copy relative path to clipboard (with line selection in visual mode)
vim.keymap.set({ 'n', 'v' }, '<leader>cr', function()
  local path = vim.fn.fnamemodify(vim.fn.expand '%', ':.')
  local mode = vim.fn.mode()
  
  if mode == 'v' or mode == 'V' then
    -- Visual mode: include line range and selected text
    local start_line = vim.fn.line "'<"
    local end_line = vim.fn.line "'>"
    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    
    local result = '@' .. path .. ':' .. start_line
    if start_line ~= end_line then
      result = result .. '-' .. end_line
    end
    result = result .. '\n' .. table.concat(lines, '\n')
    
    vim.fn.setreg('+', result)
    vim.notify('Copied to clipboard: ' .. path .. ':' .. start_line .. '-' .. end_line)
  else
    -- Normal mode: just copy the path
    vim.fn.setreg('+', '@' .. path)
    vim.notify('Copied to clipboard: ' .. path)
  end
end, { desc = 'Copy relative path to clipboard' })

-- Copy all buffer paths with @ prefix
vim.keymap.set('n', '<leader>cR', function()
  local buffers = vim.api.nvim_list_bufs()
  local paths = {}

  for _, buf in ipairs(buffers) do
    if
      vim.api.nvim_buf_is_loaded(buf)
      and vim.api.nvim_buf_get_option(buf, 'buflisted')
    then
      local bufname = vim.api.nvim_buf_get_name(buf)
      if bufname ~= '' then
        local path = vim.fn.fnamemodify(bufname, ':.')
        table.insert(paths, '@' .. path)
      end
    end
  end

  local result = table.concat(paths, ' ')
  vim.fn.setreg('+', result)
  vim.notify('Copied to clipboard: ' .. result)
end, { desc = 'Copy all buffer paths with @ prefix' })
