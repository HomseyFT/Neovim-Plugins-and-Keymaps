-- 1) sets leader
vim.g.mapleader = " "          -- space as leader
vim.g.maplocalleader = " "     

vim.keymap.set("n", "<leader>ar", function()
  -- file info
  local file = vim.fn.expand("%:p")
  local dir  = vim.fn.fnamemodify(file, ":h"):gsub("\\","/")
  local base = vim.fn.fnamemodify(file, ":t:r")
  -- required bc .com needs to be <= 8 chars
  local short = string.upper(base:gsub("%W",""):sub(1,8))
  if short == "" then short = "PROG" end

  -- build commands
  local out = string.format('%s/%s.com', dir, short)
  local assemble = string.format('nasm -f bin "%s" -o "%s"', file, out)
  local run = string.format('dosbox-x -c "mount c %s" -c "c:" -c "%s.com" -c "pause" -c "exit"', dir, short)

  vim.cmd("w")
  vim.cmd("!" .. assemble .. " && " .. run)
end, { desc = "Save + Assemble + Run (.COM in DOSBox-X, 8.3 name)" })

-- assemble only version
vim.keymap.set("n", "<leader>ab", function()
  local file = vim.fn.expand("%:p")
  local dir  = vim.fn.fnamemodify(file, ":h"):gsub("\\","/")
  local base = vim.fn.fnamemodify(file, ":t:r")
  local short = string.upper(base:gsub("%W",""):sub(1,8))
  if short == "" then short = "PROG" end
  local out = string.format('%s/%s.com', dir, short)
  vim.cmd("w")
  vim.cmd(string.format('!nasm -f bin "%s" -o "%s"', file, out))
end, { desc = "Save + Assemble (.COM, 8.3 name)" })


-- 2) telescope keymaps
local map = vim.keymap.set
local builtin = require('telescope.builtin')

map('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
map('n', '<leader>fg', builtin.live_grep,  { desc = 'Live grep' })
map('n', '<leader>fb', builtin.buffers,    { desc = 'Buffers' })
map('n', '<leader>fh', builtin.help_tags,  { desc = 'Help tags' })

-- pickers
map('n', '<leader>fr', builtin.oldfiles,   { desc = 'Recent files' })
map('n', '<leader>fs', builtin.grep_string,{ desc = 'Grep word under cursor' })

-- 3) window nav
map('n', '<C-h>', '<C-w>h', { desc = 'Left split' })
map('n', '<C-j>', '<C-w>j', { desc = 'Down split' })
map('n', '<C-k>', '<C-w>k', { desc = 'Up split' })
map('n', '<C-l>', '<C-w>l', { desc = 'Right split' })

-- 4) QOL stuff
map('n', '<leader>w', ':w<CR>', { desc = 'Save' })
map('n', '<leader>q', ':q<CR>', { desc = 'Quit' })



return {
  -- LSP config
  {
    "neovim/nvim-lspconfig",
  },

  -- autocomplete
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",   -- LSP source
      "hrsh7th/cmp-buffer",     -- buffer completions
      "hrsh7th/cmp-path",       -- filesystem paths
      "hrsh7th/cmp-cmdline",    -- command line
      "L3MON4D3/LuaSnip",       -- snippets engine
      "saadparwaiz1/cmp_luasnip", -- snippet completions
    },
  },

  -- syntax highlights
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  -- telescope fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- file explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- colorscheme
  {
    "EdenEast/nightfox.nvim",
  },
}

