return {

  { 'tpope/vim-fugitive' },
  { 'tpope/vim-rhubarb' },
  { 'akinsho/git-conflict.nvim', version = '*', config = true },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set(
          'n',
          '<leader>hp',
          require('gitsigns').preview_hunk,
          { buffer = bufnr, desc = 'Preview git hunk' }
        )
        vim.keymap.set(
          'n',
          '<leader>hn',
          require('gitsigns').nav_hunk,
          { buffer = bufnr, desc = 'Next git hunk' }
        )
        vim.keymap.set(
          'n',
          '<leader>hd',
          require('gitsigns').diffthis,
          { buffer = bufnr, desc = 'Show diff for current file' }
        )
        vim.keymap.set('n', '<leader>hb', function()
          require('gitsigns').blame_line { full = true }
        end, { buffer = bufnr, desc = 'Show blame for current line' })
        vim.keymap.set(
          'n',
          '<leader>hB',
          require('gitsigns').toggle_current_line_blame,
          { buffer = bufnr, desc = 'Toggle line blame' }
        )

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, {
          expr = true,
          buffer = bufnr,
          desc = 'Jump to previous hunk',
        })
      end,
    },
  },
}
