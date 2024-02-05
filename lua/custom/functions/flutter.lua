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

vim.api.nvim_set_keymap('n', '<leader>ot', [[:CreateFlutterTestFile<CR>]], {
    noremap = true,
    silent = true,
    desc = "Go to test file, create if doesn't exist",
})

function createBarrelFile()
    local current_file = vim.fn.expand '%:p'
    local current_dir = vim.fn.expand '%:p:h'
    -- Use this to create barrel file with custom name
    local barrel_name = current_dir .. '/export.dart'
    -- local barrel_name = current_dir
    --     .. '/'
    --     .. vim.fn.fnamemodify(current_dir, ':t')
    --     .. '.dart'

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
