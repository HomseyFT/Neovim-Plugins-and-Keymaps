-- LSP keymaps (applied when any LSP attaches to a buffer)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
    end

    map("n", "gd", vim.lsp.buf.definition, "LSP: go to definition")
    map("n", "gD", vim.lsp.buf.declaration, "LSP: go to declaration")
    map("n", "gr", vim.lsp.buf.references, "LSP: references")
    map("n", "gi", vim.lsp.buf.implementation, "LSP: implementation")
    map("n", "K", vim.lsp.buf.hover, "LSP: hover docs")
    map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: rename")
    map("n", "<leader>ca", vim.lsp.buf.code_action, "LSP: code action")
    map("n", "<leader>D", vim.lsp.buf.type_definition, "LSP: type definition")
    map("n", "[d", vim.diagnostic.goto_prev, "LSP: prev diagnostic")
    map("n", "]d", vim.diagnostic.goto_next, "LSP: next diagnostic")
    map("n", "<leader>e", vim.diagnostic.open_float, "LSP: show diagnostic")
  end,
})
