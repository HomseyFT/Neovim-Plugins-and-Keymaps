return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add          = { text = "│" },
      change       = { text = "│" },
      delete       = { text = "_" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local map = function(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
      end

      -- navigation
      map("n", "]h", gs.next_hunk, "Gitsigns: next hunk")
      map("n", "[h", gs.prev_hunk, "Gitsigns: prev hunk")

      -- actions
      map("n", "<leader>hs", gs.stage_hunk, "Gitsigns: stage hunk")
      map("n", "<leader>hr", gs.reset_hunk, "Gitsigns: reset hunk")
      map("n", "<leader>hS", gs.stage_buffer, "Gitsigns: stage buffer")
      map("n", "<leader>hu", gs.undo_stage_hunk, "Gitsigns: undo stage hunk")
      map("n", "<leader>hR", gs.reset_buffer, "Gitsigns: reset buffer")
      map("n", "<leader>hp", gs.preview_hunk, "Gitsigns: preview hunk")
      map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Gitsigns: blame line")
      map("n", "<leader>tb", gs.toggle_current_line_blame, "Gitsigns: toggle line blame")
      map("n", "<leader>hd", gs.diffthis, "Gitsigns: diff this")
    end,
  },
}
