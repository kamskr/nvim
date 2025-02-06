return {
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        '<leader>-',
        '<cmd>Yazi<cr>',
        desc = 'Open yazi at the current file',
      },
      {
        -- NOTE: this requires a version of yazi that includes
        -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
        '<c-up>',
        '<cmd>Yazi toggle<cr>',
        desc = 'Resume the last yazi session',
      },
    },
    ---@type YaziConfig
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = true,
      keymaps = {
        show_help = '?',
      },
    },
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    config = function()
      require('oil').setup {
        default_file_explorer = true,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        view_options = {
          natural_order = true,
          is_hidden_file = function(name, bufnr)
            -- Rule 1: Hide specific file names
            local hide_by_name = {
              'pubspec.lock',
              'config-staging.json',
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
        },
        keymaps = {
          ['<C-c>'] = false,
          ['<C-v>'] = 'actions.preview',
          ['q'] = 'actions.close',
          ['<C-h>'] = 'actions.toggle_hidden',
          ['?'] = 'actions.show_help',
          ['<CR>'] = 'actions.select',
          ['<C-s>'] = {
            'actions.select',
            opts = { vertical = true },
            desc = 'Open the entry in a vertical split',
          },
          ['<C-t>'] = {
            'actions.select',
            opts = { tab = true },
            desc = 'Open the entry in new tab',
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
}
