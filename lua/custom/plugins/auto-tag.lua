return {
  'windwp/nvim-ts-autotag',
  -- Optional dependency
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    require('nvim-ts-autotag').setup {}
  end,
}
