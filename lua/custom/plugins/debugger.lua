return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
  },
  config = function()
    require("dapui").setup()

    vim.keymap.set("n", "<leader>du", function()
      require("dapui").toggle()
    end, { desc = 'Toggle debug UI' })

    vim.keymap.set("n", "<leader>db", function()
      require("dap").toggle_breakpoint()
    end, { desc = 'Toggle breakpoint' })

    vim.keymap.set("n", "<leader>dc", function()
      require("dap").continue()
    end, { desc = 'Debuger continue' })

    vim.keymap.set("n", "<leader>di", function()
      require("dap").step_into()
    end, { desc = 'Debuger step into' })

    vim.keymap.set("n", "<leader>do", function()
      require("dap").step_over()
    end, { desc = 'Debuger step over' })
  end
}
