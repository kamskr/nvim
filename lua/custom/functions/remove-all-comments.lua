local M = {}

-- Table of comment patterns for different file types
local comment_patterns = {
  lua = '--',
  python = '#',
  javascript = '//',
  typescript = '//',
  cpp = '//',
  c = '//',
  rust = '//',
  java = '//',
  vim = '"',
  sh = '#',
  bash = '#',
  zsh = '#',
  yaml = '#',
  dart = '//',
}

-- Function to remove single-line comments
local function remove_single_line_comments()
  local filetype = vim.bo.filetype
  local pattern = comment_patterns[filetype]

  if pattern then
    -- Remove full-line comments
    vim.cmd(string.format('g/^\\s*%s/d', pattern))
    -- Remove end of line comments
    vim.cmd(string.format('%%s/\\s*%s.*$//e', pattern))
  end
end

-- Function to remove multi-line comments
local function remove_multi_line_comments()
  local filetype = vim.bo.filetype

  -- Handle C-style multi-line comments (/* ... */)
  if
    filetype == 'javascript'
    or filetype == 'typescript'
    or filetype == 'cpp'
    or filetype == 'c'
    or filetype == 'java'
  then
    vim.cmd [[%s/\/\*\_.\{-}\*\///ge]]
  end

  -- Handle Lua multi-line comments --[[ ... ]]
  if filetype == 'lua' then
    vim.cmd [[%s/--\[\[\_.\{-}\]\]//ge]]
  end
end

-- Main function to remove all comments
function M.remove_all_comments()
  -- Save cursor position
  local cursor_pos = vim.fn.getcurpos()

  -- Remove single-line comments
  remove_single_line_comments()

  -- Remove multi-line comments
  remove_multi_line_comments()

  -- Restore cursor position
  vim.fn.setpos('.', cursor_pos)

  -- Remove empty lines
  vim.cmd [[g/^\s*$/d]]

  -- Print message
  print 'Comments removed!'
end

-- Setup keymapping
function M.setup()
  vim.keymap.set(
    'n',
    '<leader>rc',
    M.remove_all_comments,
    { desc = '[R]emove all [C]omments', silent = true }
  )
end

return M
