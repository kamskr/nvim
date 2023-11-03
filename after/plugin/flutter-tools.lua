require("flutter-tools").setup {
    fvm = true,
    widget_guides = {
        enabled = true,
    },
    debugger = { -- integrate with nvim dap + install dart code debugger
        enabled = false,
        run_via_dap = false, -- use dap instead of a plenary job to run flutter apps
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
-- Automatically run dartfix on save for Dart files
-- vim.cmd('autocmd BufWritePost *.dart :!fvm dart fix % --apply')
vim.api.nvim_set_keymap('n', '<leader>df', ':!fvm dart fix % --apply<CR>', { noremap = true, silent = true })

function formatDartBuffer()
    -- Check if the current buffer's filetype is "dart"
    if vim.bo.filetype == 'dart' then
        -- Save the current cursor position
        local cursor_position = vim.fn.getpos('.')

        -- Move to the beginning of the buffer and format to the end
        vim.cmd([[1]])
        vim.cmd([[execute 'normal! ggVGgq']])

        -- Restore the cursor position
        vim.fn.setpos('.', cursor_position)
    end
end

-- Automatically format Dart files before saving
vim.api.nvim_command([[autocmd BufWritePre *.dart lua formatDartBuffer()]])


function createNestedDirectory(directoryPath)
    -- Recursive function to create nested directories
    local parentDirectory = vim.fn.fnamemodify(directoryPath, ":h")
    if parentDirectory ~= directoryPath and parentDirectory ~= "" then
        createNestedDirectory(parentDirectory)
    end

    -- Create the directory if it doesn't exist
    if vim.fn.isdirectory(directoryPath) == 0 then
        vim.fn.mkdir(directoryPath, "p")
    end
end

function createFlutterTestFile()
    -- Get the path of the current buffer
    local currentFilePath = vim.fn.expand("%:p")

    -- Extract the directory and file name from the current file path
    local directory, fileName = currentFilePath:match("(.*/)(.*)%.dart$")

    -- Check if the current file is in the 'lib' directory
    if directory and fileName then
        local testDirectory = directory:gsub("/lib/", "/test/") -- Replace '/lib/' with '/test/'
        local testFileName = fileName .. "_test.dart"
        local testFilePath = testDirectory .. testFileName

        -- Check if the test file already exists
        if vim.fn.filereadable(testFilePath) == 0 then
            -- Create the test directory if it doesn't exist
            vim.fn.mkdir(testDirectory, "p")

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
                print('Failed to create the file.')
            end
        else
            -- If the test file already exists, open it for editing
            local cmd = "e " .. testFilePath
            vim.cmd(cmd)
            print("Opened existing test file: " .. testFilePath)
        end
    else
        print("This action is only applicable to Dart files in the 'lib' directory.")
    end
end

vim.cmd([[command! CreateFlutterTestFile lua createFlutterTestFile()]])

vim.api.nvim_set_keymap('n', '<leader>ot', [[:CreateFlutterTestFile<CR>]], { noremap = true, silent = true })

function createBarrelFile()
    local current_file = vim.fn.expand("%:p")
    local current_dir = vim.fn.expand("%:p:h")
    -- Use this to create barrel file with custom name
    local barrel_name = current_dir .. "/index.dart"
    local barrel_name = current_dir .. "/" .. vim.fn.fnamemodify(current_dir, ":t") .. ".dart"

    local current_filename = vim.fn.fnamemodify(current_file, ":t:r")

    -- Read the existing barrel file
    local barrel_content = {}
    local existing_exports = {}
    local existing_file = io.open(barrel_name, "r")
    if existing_file then
        for line in existing_file:lines() do
            table.insert(barrel_content, line)
            local export = line:match("export '([^']+)';")
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
    local barrel_file = io.open(barrel_name, "w")
    if barrel_file then
        for _, line in ipairs(export_lines) do
            barrel_file:write(line .. "\n")
        end
        barrel_file:close()
    end
end

-- Create a custom Neovim command for the barrel file creation
vim.cmd([[command! CreateBarrelFile lua createBarrelFile()]])

-- Map <leader>ob to trigger the custom command in normal mode
vim.api.nvim_set_keymap('n', '<leader>cb', [[:CreateBarrelFile<CR>]], { noremap = true, silent = true })
