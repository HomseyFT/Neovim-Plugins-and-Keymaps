local map = vim.keymap.set

-- assembly: assemble + run in DOSBox-X
map("n", "<leader>ar", function()
  local file = vim.fn.expand("%:p")
  local dir  = vim.fn.fnamemodify(file, ":h"):gsub("\\","/")
  local base = vim.fn.fnamemodify(file, ":t:r")
  local short = string.upper(base:gsub("%W",""):sub(1,8))
  if short == "" then short = "PROG" end

  local out = string.format('%s/%s.com', dir, short)
  local assemble = string.format('nasm -f bin "%s" -o "%s"', file, out)
  local run = string.format('dosbox-x -c "mount c %s" -c "c:" -c "%s.com" -c "pause" -c "exit"', dir, short)

  vim.cmd("w")
  vim.cmd("!" .. assemble .. " && " .. run)
end, { desc = "Save + Assemble + Run (.COM in DOSBox-X, 8.3 name)" })

-- assembly: assemble only
map("n", "<leader>ab", function()
  local file = vim.fn.expand("%:p")
  local dir  = vim.fn.fnamemodify(file, ":h"):gsub("\\","/")
  local base = vim.fn.fnamemodify(file, ":t:r")
  local short = string.upper(base:gsub("%W",""):sub(1,8))
  if short == "" then short = "PROG" end
  local out = string.format('%s/%s.com', dir, short)
  vim.cmd("w")
  vim.cmd(string.format('!nasm -f bin "%s" -o "%s"', file, out))
end, { desc = "Save + Assemble (.COM, 8.3 name)" })

-- telescope (loaded lazily via autocmd after plugins are ready)
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  once = true,
  callback = function()
    local builtin = require('telescope.builtin')
    map('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
    map('n', '<leader>fg', builtin.live_grep,  { desc = 'Live grep' })
    map('n', '<leader>fb', builtin.buffers,    { desc = 'Buffers' })
    map('n', '<leader>fh', builtin.help_tags,  { desc = 'Help tags' })
    map('n', '<leader>fr', builtin.oldfiles,   { desc = 'Recent files' })
    map('n', '<leader>fs', builtin.grep_string,{ desc = 'Grep word under cursor' })
  end,
})

-- window nav
map('n', '<C-h>', '<C-w>h', { desc = 'Left split' })
map('n', '<C-j>', '<C-w>j', { desc = 'Down split' })
map('n', '<C-k>', '<C-w>k', { desc = 'Up split' })
map('n', '<C-l>', '<C-w>l', { desc = 'Right split' })

-- QOL
map('n', '<leader>w', ':w<CR>', { desc = 'Save' })
map('n', '<leader>q', ':q<CR>', { desc = 'Quit' })
