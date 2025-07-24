-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'nvim-neotest/nvim-nio',
    -- Toggle stop at exception breakpoints
    'lucaSartore/nvim-dap-exception-breakpoints',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- Setup Catppuccin-compatible DAP highlights
    local function setup_dap_highlights()
      -- Get Catppuccin colors
      local colors = {
        rosewater = '#f5e0dc',
        flamingo = '#f2cdcd',
        pink = '#f5c2e7',
        mauve = '#cba6f7',
        red = '#f38ba8',
        maroon = '#eba0ac',
        peach = '#fab387',
        yellow = '#f9e2af',
        green = '#a6e3a1',
        teal = '#94e2d5',
        sky = '#89dceb',
        sapphire = '#74c7ec',
        blue = '#89b4fa',
        lavender = '#b4befe',
        text = '#cdd6f4',
        subtext1 = '#bac2de',
        subtext0 = '#a6adc8',
        overlay2 = '#9399b2',
        overlay1 = '#7f849c',
        overlay0 = '#6c7086',
        surface2 = '#585b70',
        surface1 = '#45475a',
        surface0 = '#313244',
        base = '#1e1e2e',
        mantle = '#181825',
        crust = '#11111b',
      }

      -- DAP Breakpoint highlights
      vim.api.nvim_set_hl(0, 'DapBreakpoint', {
        ctermbg = 0,
        fg = colors.red,
        bg = colors.surface0,
      })
      vim.api.nvim_set_hl(0, 'DapLogPoint', {
        ctermbg = 0,
        fg = colors.blue,
        bg = colors.surface0,
      })
      vim.api.nvim_set_hl(0, 'DapStopped', {
        ctermbg = 0,
        fg = colors.green,
        bg = colors.surface0,
      })

      -- DAP UI highlights
      vim.api.nvim_set_hl(0, 'DapUIScope', { fg = colors.sky })
      vim.api.nvim_set_hl(0, 'DapUIType', { fg = colors.mauve })
      vim.api.nvim_set_hl(0, 'DapUIValue', { fg = colors.text })
      vim.api.nvim_set_hl(
        0,
        'DapUIModifiedValue',
        { fg = colors.peach, bold = true }
      )
      vim.api.nvim_set_hl(0, 'DapUIDecoration', { fg = colors.blue })
      vim.api.nvim_set_hl(0, 'DapUIThread', { fg = colors.green })
      vim.api.nvim_set_hl(0, 'DapUIStoppedThread', { fg = colors.sky })
      vim.api.nvim_set_hl(0, 'DapUIFrameName', { fg = colors.text })
      vim.api.nvim_set_hl(0, 'DapUISource', { fg = colors.lavender })
      vim.api.nvim_set_hl(0, 'DapUILineNumber', { fg = colors.overlay0 })
      vim.api.nvim_set_hl(0, 'DapUIFloatBorder', { fg = colors.surface2 })
      vim.api.nvim_set_hl(0, 'DapUIWatchesEmpty', { fg = colors.maroon })
      vim.api.nvim_set_hl(0, 'DapUIWatchesValue', { fg = colors.green })
      vim.api.nvim_set_hl(0, 'DapUIWatchesError', { fg = colors.red })
      vim.api.nvim_set_hl(0, 'DapUIBreakpointsPath', { fg = colors.sky })
      vim.api.nvim_set_hl(0, 'DapUIBreakpointsInfo', { fg = colors.green })
      vim.api.nvim_set_hl(
        0,
        'DapUIBreakpointsCurrentLine',
        { fg = colors.peach, bold = true }
      )

      -- REPL specific highlights
      vim.api.nvim_set_hl(0, 'DapUIConsole', { fg = colors.text })
      vim.api.nvim_set_hl(0, 'DapUIConsoleNC', { fg = colors.text })
      vim.api.nvim_set_hl(0, 'DapUIWinSelect', { fg = colors.sky, bold = true })
      vim.api.nvim_set_hl(0, 'DapUIEndofBuffer', { fg = colors.surface0 })

      -- Virtual text highlights
      vim.api.nvim_set_hl(0, 'DapUIVariable', { fg = colors.text })
      vim.api.nvim_set_hl(0, 'DapUIPlayPause', { fg = colors.green })
      vim.api.nvim_set_hl(0, 'DapUIRestart', { fg = colors.yellow })
      vim.api.nvim_set_hl(0, 'DapUIStop', { fg = colors.red })
      vim.api.nvim_set_hl(0, 'DapUIUnavailable', { fg = colors.overlay0 })
      vim.api.nvim_set_hl(0, 'DapUIStepOver', { fg = colors.blue })
      vim.api.nvim_set_hl(0, 'DapUIStepInto', { fg = colors.blue })
      vim.api.nvim_set_hl(0, 'DapUIStepBack', { fg = colors.blue })
      vim.api.nvim_set_hl(0, 'DapUIStepOut', { fg = colors.blue })
    end

    -- Apply highlights
    setup_dap_highlights()

    -- Reapply highlights when colorscheme changes
    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = '*',
      callback = setup_dap_highlights,
    })

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    dap.adapters.dart = {
      type = 'executable',
      command = 'dart', -- if you're using fvm, you'll need to provide the full path to dart (dart.exe for windows users), or you could prepend the fvm command
      args = { 'debug_adapter' },
      -- windows users will need to set 'detached' to false
      options = {
        detached = false,
      },
    }
    dap.adapters.flutter = {
      type = 'executable',
      command = 'flutter', -- if you're using fvm, you'll need to provide the full path to flutter (flutter.bat for windows users), or you could prepend the fvm command
      args = { 'debug_adapter' },
      -- windows users will need to set 'detached' to false
      options = {
        detached = false,
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set(
      'n',
      '<leader>dc',
      dap.continue,
      { desc = 'Debug: Start/Continue' }
    )
    vim.keymap.set(
      'n',
      '<leader>di',
      dap.step_into,
      { desc = 'Debug: Step Into' }
    )
    vim.keymap.set(
      'n',
      '<leader>do',
      dap.step_over,
      { desc = 'Debug: Step Over' }
    )
    vim.keymap.set(
      'n',
      '<leader>dt',
      dap.step_out,
      { desc = 'Debug: Step Out' }
    )
    vim.keymap.set(
      'n',
      '<leader>db',
      dap.toggle_breakpoint,
      { desc = 'Debug: Toggle Breakpoint' }
    )
    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    vim.keymap.set(
      'n',
      '<leader>dC',
      dap.repl.clear,
      { desc = 'Debug: Clear Console' }
    )

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
      -- Enhanced rendering for better colors
      render = {
        max_type_length = nil, -- Can be integer or nil
        max_value_lines = 100, -- Can be integer or nil
        indent = 1,
      },
      -- Enable syntax highlighting in windows
      expand_lines = true,
      layouts = {
        {
          elements = {
            {
              id = 'stacks',
              size = 0.1,
            },
            {
              id = 'breakpoints',
              size = 0.3,
            },
            {
              id = 'watches',
              size = 0.1,
            },
            {
              id = 'scopes',
              size = 0.5,
            },
          },
          position = 'left',
          size = 40,
        },
        {
          elements = {
            {
              id = 'repl',
              size = 1,
            },
          },
          position = 'right',
          size = 40,
        },
      },
    }

    -- Configure REPL console with proper colors
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'dapui_console',
      callback = function()
        -- Enable syntax highlighting for REPL console
        vim.bo.syntax = 'on'
        vim.bo.filetype = 'dapui_console'

        -- Set up buffer-local highlights for better readability
        vim.api.nvim_buf_set_option(0, 'wrap', true)
        vim.api.nvim_buf_set_option(0, 'linebreak', true)

        -- Enable colors in the REPL
        vim.env.FORCE_COLOR = '1'
        vim.env.CLICOLOR_FORCE = '1'
      end,
    })

    -- Enhanced REPL toggle with better positioning
    vim.keymap.set('n', '<leader>dr', function()
      require('dapui').toggle 'repl'
    end, { desc = 'Debug: Toggle REPL' })

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set(
      'n',
      '<leader>du',
      dapui.toggle,
      { desc = 'Debug: toggle UI' }
    )

    -- Enhanced DAP listeners with better error handling
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    -- Configure console output with colors
    dap.defaults.fallback.terminal_win_cmd = '50vsplit new'
    dap.defaults.fallback.focus_terminal = true

    local set_exception_breakpoints = require 'nvim-dap-exception-breakpoints'

    vim.api.nvim_set_keymap('n', '<leader>de', '', {
      desc = '[D]ebug [E]xception condition breakpoints',
      callback = set_exception_breakpoints,
    })

    vim.api.nvim_set_keymap('n', '<leader>dk', '', {
      desc = 'Eval under cursor',
      callback = function()
        require('dapui').eval(nil, { enter = true })
      end,
    })

    -- Additional keymaps for better workflow
    vim.keymap.set('n', '<leader>dh', function()
      require('dap.ui.widgets').hover()
    end, { desc = 'Debug: Hover Variables' })

    vim.keymap.set('n', '<leader>dp', function()
      require('dap.ui.widgets').preview()
    end, { desc = 'Debug: Preview' })

    vim.keymap.set('n', '<leader>df', function()
      local widgets = require 'dap.ui.widgets'
      widgets.centered_float(widgets.frames)
    end, { desc = 'Debug: Show Frames' })

    vim.keymap.set('n', '<leader>ds', function()
      local widgets = require 'dap.ui.widgets'
      widgets.centered_float(widgets.scopes)
    end, { desc = 'Debug: Show Scopes' })
  end,
}
