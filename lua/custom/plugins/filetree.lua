return {
  {
    'stevearc/oil.nvim',
    opts = {},
    config = function()
      require('oil').setup {
        default_file_explorer = true,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        watch_for_changes = true,
        columns = {
          'icon',
          -- "permissions",
          -- 'size',
          -- "mtime",
        },
        view_options = {
          natural_order = true,
          is_hidden_file = function(name, bufnr)
            -- Rule 1: Hide specific file names
            local hide_by_name = {
              'pubspec.lock',
              'config-staging.json',
              'config-migration.json',
              'config-production.json',
              'config-example.json',
              'config-development.json',
              'custom_lint.log',
              'flutter_launcher_icons-development.yaml',
              'flutter_launcher_icons-production.yaml',
              'flutter_launcher_icons-staging.yaml',
              'flutter_native_splash-development.yaml',
              'flutter_native_splash-production.yaml',
              'flutter_native_splash-staging.yaml',
            }

            for _, hidden_name in ipairs(hide_by_name) do
              if name == hidden_name then
                return true
              end
            end

            -- Rule 2: Hide files matching specific patterns
            local hide_by_pattern = {
              '.*%.g%.dart',
              '.*%.freezed%.dart',
            }

            for _, pattern in ipairs(hide_by_pattern) do
              if string.match(name, pattern) then
                return true
              end
            end

            -- Default rule: Check if the file starts with a dot
            return vim.startswith(name, '.')
          end,
          is_always_hidden = function(name, _)
            return name == '..' or name == '.git'
          end,
        },
        float = {
          padding = 2,
          max_width = 90,
          max_height = 0,
        },
        win_options = {
          wrap = true,
          winblend = 0,
          signcolumn = 'yes:2',
        },
        keymaps = {
          ['<C-c>'] = false,
          ['<C-v>'] = 'actions.preview',
          ['q'] = 'actions.close',
          ['<C-t>'] = 'actions.toggle_hidden',
          ['?'] = 'actions.show_help',
          ['<CR>'] = 'actions.select',
          ['<C-s>'] = {
            'actions.select',
            opts = { vertical = true },
            desc = 'Open the entry in a vertical split',
          },
          ['<C-r>'] = 'actions.refresh',
          ['-'] = 'actions.parent',
          ['_'] = 'actions.open_cwd',
          ['`'] = 'actions.cd',
          ['~'] = {
            'actions.cd',
            opts = { scope = 'tab' },
            desc = ':tcd to the current oil directory',
          },
          ['gs'] = 'actions.change_sort',
          ['gx'] = 'actions.open_external',
          ['g\\'] = 'actions.toggle_trash',
        },
        use_default_keymaps = false,
      }

      vim.keymap.set(
        'n',
        '-',
        '<CMD>Oil<CR>',
        { desc = 'Open parent directory' }
      )
    end,
  },
  {
    'refractalize/oil-git-status.nvim',

    dependencies = {
      'stevearc/oil.nvim',
    },

    config = true,
  },
  {
    'JezerM/oil-lsp-diagnostics.nvim',
    dependencies = { 'stevearc/oil.nvim' },
    opts = {},
  },
}
