-- This is just so that gc comment out works in jsx
return {
  'folke/ts-comments.nvim',
  opts = {},
  event = 'VeryLazy',
  enabled = vim.fn.has 'nvim-0.10.0' == 1,
}
