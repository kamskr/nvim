-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.material_style = 'deep ocean'

vim.opt.colorcolumn = '80'
vim.opt.relativenumber = true
vim.o.exrc = true
vim.opt.spelllang = 'en_us'
vim.opt.spell = true

vim.g.copilot_assume_mapped = true

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure plugins ]]
require 'lazy-plugins'

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'
require 'custom/functions/flutter'
require 'custom/functions/typescript'
require 'custom/functions/auto-build-arb'
--
-- [[ Configure Telescope ]]
-- (fuzzy finder)
require 'telescope-setup'

-- [[ Configure Treesitter ]]
-- (syntax parser for highlighting)
require 'treesitter-setup'

-- [[ Configure LSP ]]
-- (Language Server Protocol)
-- require 'lsp-setup'

-- [[ Configure nvim-cmp ]]
-- (completion)
require 'cmp-setup'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

vim.filetype.add {
  extension = {
    arb = 'json',
  },
}
