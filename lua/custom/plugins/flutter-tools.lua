return {
  -- {
  --   'wa11breaker/flutter-bloc.nvim',
  --   dependencies = {
  --     'nvimtools/none-ls.nvim', -- Required for code actions
  --   },
  --   opts = {
  --     bloc_type = 'equatable', -- Choose from: 'default', 'equatable', 'freezed'
  --     use_sealed_classes = false,
  --     enable_code_actions = true,
  --   },
  -- },
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function()
      require('flutter-tools').setup {
        decorations = {
          statusline = {
            -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
            -- this will show the current version of the flutter app from the pubspec.yaml file
            app_version = true,
            -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
            -- this will show the currently running device if an application was started with a specific
            -- device
            device = true,
            -- set to true to be able use the 'flutter_tools_decorations.project_config' in your statusline
            -- this will show the currently selected project configuration
            project_config = true,
          },
        },
        fvm = true,
        widget_guides = {
          enabled = true,
        },
        debugger = { -- integrate with nvim dap + install dart code debugger
          enabled = true,
          exception_breakpoints = {
            'uncaughted',
            'raised',
          },
          register_configurations = function(_)
            require('dap').configurations.dart = {}
            require('dap.ext.vscode').load_launchjs()
          end,
        },
        dev_log = {
          enabled = true,
          notify_errors = true, -- if there is an error whilst running then notify the user
          -- open_cmd = "tabedit", -- command to use to open the log buffer
        },
        lsp = {
          color = { -- show the derived colours for dart variables
            enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
            background = false, -- highlight the background
            background_color = { r = 19, g = 17, b = 24 }, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
            foreground = false, -- highlight the foreground
            virtual_text = true, -- show the highlight using virtual text
            virtual_text_str = '■', -- the virtual text character to highlight
          },
          settings = {
            showTodos = false,
            completeFunctionCalls = true,
            analysisExcludedFolders = {
              vim.fn.expand '$HOME/AppData/Local/Pub/Cache',
              vim.fn.expand '$HOME/.pub-cache',
              vim.fn.expand '/opt/homebrew/',
              -- vim.fn.expand '$HOME/tools/flutter/',
              -- vim.fn.expand '$HOME/tools/flutter/',
              -- vim.fn.expand '~/fvm/',
            },
            renameFilesWithClasses = 'prompt', -- "always"
            enableSnippets = false,
            updateImportsOnRename = true, -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
          },
        },
      }
    end,
  },
}
