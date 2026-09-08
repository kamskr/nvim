-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Uses the `main` branch API: parsers are installed explicitly and
-- highlighting/indent are enabled per buffer via Neovim's built-in treesitter.
local ts = require 'nvim-treesitter'

local ensure_installed = {
  'c',
  'lua',
  'vim',
  'vimdoc',
  'query',
  'javascript',
  'typescript',
  'dart',
  'ruby',
  'python',
}

-- Defer parser installation after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  ts.install(ensure_installed)
end, 0)

local available = ts.get_available()

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('treesitter-setup', { clear = true }),
  callback = function(args)
    local buf = args.buf
    local lang = vim.treesitter.language.get_lang(args.match)
    if not lang then
      return
    end

    local function start()
      if not vim.api.nvim_buf_is_valid(buf) then
        return
      end
      vim.treesitter.start(buf, lang)
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end

    if vim.treesitter.language.add(lang) then
      start()
    elseif vim.tbl_contains(available, lang) then
      -- Automatically install missing parsers when entering buffer
      ts.install(lang):await(function(err)
        if not err then
          vim.schedule(start)
        end
      end)
    end
  end,
})

-- vim: ts=2 sts=2 sw=2 et
