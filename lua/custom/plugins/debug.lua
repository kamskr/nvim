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
    'lucaSartore/nvim-dap-exception-breakpoints',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

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
              size = 0.4,
            },
            {
              id = 'repl',
              size = 0.1,
            },
          },
          position = 'left',
          size = 40,
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set(
      'n',
      '<leader>du',
      dapui.toggle,
      { desc = 'Debug: toggle UI' }
    )

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

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
  end,
}
