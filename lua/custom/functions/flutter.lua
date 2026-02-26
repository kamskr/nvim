-- Automatically run dartfix on save for Dart files
-- vim.cmd('autocmd BufWritePost *.dart :!fvm dart fix % --apply')

function auto_fix_on_save()
  if next(vim.lsp.get_active_clients()) ~= nil then
    vim.lsp.buf.code_action {
      filter = function(action)
        return action.title == 'Fix All'
      end,
      apply = true,
    }
  end
end

vim.cmd [[ autocmd BufWritePre *.dart lua auto_fix_on_save() ]]
vim.api.nvim_set_keymap(
  'n',
  '<leader>df',
  ':!fvm dart fix % --apply<CR>',
  { noremap = true, silent = true }
)

vim.api.nvim_create_user_command('FlutterDetachedRun', function(opts)
  local env = opts.fargs[1] or 'none'
  local cwd = vim.fn.getcwd()
  local project = vim.fn.fnamemodify(cwd, ':t')

  -- Get current tmux session name
  local current_session =
    vim.fn.system({ 'tmux', 'display-message', '-p', '#S' }):gsub('%s+', '')

  -- Handle case when not inside tmux
  if current_session == '' then
    print '❌ Not inside a tmux session.'
    return
  end

  -- Determine window name and command
  local prefix = project .. '_' .. env
  local flutter_cmd = nil

  local function build_flutter_command(env)
    if env == 'development' then
      return {
        'fvm',
        'flutter',
        'run',
        '-t',
        'lib/main_development.dart',
        '--flavor',
        'development',
        '--dart-define-from-file',
        'config-development.json',
      }
    elseif env == 'staging' then
      return {
        'fvm',
        'flutter',
        'run',
        '-t',
        'lib/main_staging.dart',
        '--flavor',
        'staging',
        '--dart-define-from-file',
        'config-staging.json',
      }
    elseif env == 'production' then
      return {
        'fvm',
        'flutter',
        'run',
        '-t',
        'lib/main_production.dart',
        '--flavor',
        'production',
        '--dart-define-from-file',
        'config-production.json',
      }
    else
      return { 'fvm', 'flutter', 'run' }
    end
  end

  flutter_cmd = build_flutter_command(env)

  -- Find a free window name (auto-increment)
  local i = 1
  local window_name = prefix .. '_' .. i
  local existing = vim.fn.systemlist {
    'tmux',
    'list-windows',
    '-t',
    current_session,
    '-F',
    '#W',
  }
  local name_set = {}
  for _, w in ipairs(existing) do
    name_set[w] = true
  end
  while name_set[window_name] do
    i = i + 1
    window_name = prefix .. '_' .. i
  end

  -- find the last numeric window index in this tmux session
  local windows = vim.fn.systemlist {
    'tmux',
    'list-windows',
    '-t',
    current_session,
    '-F',
    '#{window_index}',
  }
  local max_index = 0
  for _, idx in ipairs(windows) do
    local n = tonumber(idx)
    if n and n > max_index then
      max_index = n
    end
  end
  local next_index = max_index + 1

  -- create the new flutter window *after* all existing ones
  vim.fn.jobstart({
    'tmux',
    'new-window',
    '-t',
    string.format('%s:%d', current_session, next_index),
    '-n',
    window_name,
    'bash',
    '-lc',
    table.concat(flutter_cmd, ' '),
  }, { detach = true })

  print(
    '🚀 Started Flutter (' .. env .. ') in window [' .. window_name .. ']'
  )
end, {
  nargs = '?',
  desc = 'Run Flutter in a new tmux window of the current session',
  complete = function()
    return { 'development', 'staging', 'production', 'none' }
  end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*.dart',
  callback = function()
    -- current working directory name, as project hint
    local project = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')

    -- collect all panes
    local panes = vim.fn.systemlist {
      'tmux',
      'list-panes',
      '-a',
      '-F',
      '#{session_name}:#{window_index}.#{pane_index}:#{pane_tty}:#{pane_current_command}',
    }

    local count = 0
    for _, line in ipairs(panes) do
      -- line example: 0:1.1:/dev/ttys018:fvm
      local session, win, pane, tty, cmd =
        string.match(line, '([^:]+):([^%.]+)%.([^:]+):([^:]+):(.+)')
      if cmd and (cmd:match 'flutter' or cmd:match 'fvm') then
        local target = string.format('%s:%s.%s', session, win, pane)
        vim.fn.jobstart { 'tmux', 'send-keys', '-t', target, 'r', 'Enter' }
        count = count + 1
      end
    end

    if count > 0 then
      print('🔁 Hot reloaded ' .. count .. ' Flutter pane(s)')
    else
      print 'ℹ️ No Flutter panes detected.'
    end
  end,
})

function createNestedDirectory(directoryPath)
  -- Recursive function to create nested directories
  local parentDirectory = im.fn.fnamemodify(directoryPath, ':h')
  if parentDirectory ~= directoryPath and parentDirectory ~= '' then
    createNestedDirectory(parentDirectory)
  end

  -- Create the directory if it doesn't exist
  if vim.fn.isdirectory(directoryPath) == 0 then
    vim.fn.mkdir(directoryPath, 'p')
  end
end

function createFlutterTestFile()
  -- Get the path of the current buffer
  local currentFilePath = vim.fn.expand '%:p'

  -- Extract the directory and file name from the current file path
  local directory, fileName = currentFilePath:match '(.*/)(.*)%.dart$'

  -- Check if the current file is in the 'lib' directory
  if directory and fileName then
    local testDirectory = directory:gsub('/lib/', '/test/') -- Replace '/lib/' with '/test/'
    local testFileName = fileName .. '_test.dart'
    local testFilePath = testDirectory .. testFileName

    -- Check if the test file already exists
    if vim.fn.filereadable(testFilePath) == 0 then
      -- Create the test directory if it doesn't exist
      vim.fn.mkdir(testDirectory, 'p')

      local customContent = [[
import 'package:flutter_test/flutter_test.dart';

void main() {
// Your test code here
}
]]
      local file = io.open(testFilePath, 'w')
      if file then
        file:write(customContent)
        file:close()

        -- Open the test file for editing
        local cmd = 'e ' .. testFilePath
        vim.cmd(cmd)
        print('Created and opened test file: ' .. testFilePath)
      else
        print 'Failed to create the file.'
      end
    else
      -- If the test file already exists, open it for editing
      local cmd = 'e ' .. testFilePath
      vim.cmd(cmd)
      print('Opened existing test file: ' .. testFilePath)
    end
  else
    print "This action is only applicable to Dart files in the 'lib' directory."
  end
end

vim.cmd [[command! CreateFlutterTestFile lua createFlutterTestFile()]]

vim.api.nvim_set_keymap('n', '<leader>tf', [[:CreateFlutterTestFile<CR>]], {
  noremap = true,
  silent = true,
  desc = "Go to test file, create if doesn't exist",
})

function createBarrelFile()
  local current_file = vim.fn.expand '%:p'
  local current_dir = vim.fn.expand '%:p:h'
  -- Use this to create barrel file with custom name
  -- local barrel_name = current_dir .. '/export.dart'
  local barrel_name = current_dir
    .. '/'
    .. vim.fn.fnamemodify(current_dir, ':t')
    .. '.dart'

  local current_filename = vim.fn.fnamemodify(current_file, ':t:r')

  -- Read the existing barrel file
  local barrel_content = {}
  local existing_exports = {}
  local existing_file = io.open(barrel_name, 'r')
  if existing_file then
    for line in existing_file:lines() do
      table.insert(barrel_content, line)
      local export = line:match "export '([^']+)';"
      if export then
        existing_exports[export] = true
      end
    end
    existing_file:close()
  end

  -- Extract the existing export statements
  local export_lines = {}
  for export in pairs(existing_exports) do
    table.insert(export_lines, string.format("export '%s';", export))
  end

  -- Add missing exports
  local current_export = string.format("export '%s.dart';", current_filename)
  if not existing_exports[current_export] then
    table.insert(export_lines, current_export)
  end

  -- Sort the export lines alphabetically
  table.sort(export_lines)

  -- Update the barrel file
  local barrel_file = io.open(barrel_name, 'w')
  if barrel_file then
    for _, line in ipairs(export_lines) do
      barrel_file:write(line .. '\n')
    end
    barrel_file:close()
  end
end

vim.cmd [[command! CreateBarrelFile lua createBarrelFile()]]
vim.api.nvim_set_keymap(
  'n',
  '<leader>cb',
  [[:CreateBarrelFile<CR>]],
  { noremap = true, silent = true, desc = 'Create barrel file' }
)
