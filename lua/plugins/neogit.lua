return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local neogit = require("neogit")
      neogit.setup({
        integrations = {
          telescope = true,
          diffview = true,
        },
      })
      vim.keymap.set("n", "<leader>gg", neogit.open, { desc = "Neogit: open" })
      vim.keymap.set("n", "<leader>gc", function() neogit.open({ "commit" }) end, { desc = "Neogit: commit" })
      vim.keymap.set("n", "<leader>gp", function() neogit.open({ "push" }) end, { desc = "Neogit: push" })
      vim.keymap.set("n", "<leader>gl", function() neogit.open({ "log" }) end, { desc = "Neogit: log" })
    end,
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Diffview: open" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "Diffview: file history" },
    },
  },
}
