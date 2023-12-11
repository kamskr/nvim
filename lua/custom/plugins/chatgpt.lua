return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  config = function()
    require("chatgpt").setup({
      api_key_cmd = "op read op://Personal/3ahhhr2psfaojhfadarpkf6ube/credential --no-newline"
    })
    vim.api.nvim_set_keymap('n', '<leader>oc', [[:ChatGPT<CR>]],
      { noremap = true, silent = true, desc = "[O]pen [C]hat [G]PT" })
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim"
  }
}
