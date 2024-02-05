function createIndexBarrel()
    local current_file = vim.fn.expand '%:p'
    local current_dir = vim.fn.expand '%:p:h'
    local barrel_name = current_dir .. '/index.ts'

    local current_filename = vim.fn.fnamemodify(current_file, ':t:r')

    -- Read the existing barrel file
    local barrel_content = {}
    local existing_exports = {}
    local existing_file = io.open(barrel_name, 'r')
    if existing_file then
        for line in existing_file:lines() do
            table.insert(barrel_content, line)
            local export = line:match "export %* from '([^']+)';"
            if export then
                existing_exports[export] = true
            end
        end
        existing_file:close()
    end

    -- Extract the existing export statements
    local export_lines = {}
    for export in pairs(existing_exports) do
        table.insert(export_lines, string.format("export * from '%s';", export))
    end

    -- Add missing exports
    local current_export =
        string.format("export * from './%s';", current_filename)
    if not existing_exports[current_filename] then
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

vim.cmd [[command! CreateIndexBarrel lua createIndexBarrel()]]
vim.api.nvim_set_keymap(
    'n',
    '<leader>ci',
    [[:CreateIndexBarrel<CR>]],
    { noremap = true, silent = true, desc = 'Create index.ts file' }
)
