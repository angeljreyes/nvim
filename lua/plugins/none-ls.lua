return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local btins = null_ls.builtins
    null_ls.setup({
      sources = {
        btins.formatting.csharpier,
        btins.formatting.stylua,
        btins.formatting.isort,
        btins.formatting.prettier.with({
          extra_filetypes = { "angular" },
        }),
      },
    })

    vim.keymap.set("n", "<leader>cf", function()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      local is_null_ls_attached = vim.iter(clients):any(function(client) return client.name == "null-ls" end)
      if is_null_ls_attached then
        vim.lsp.buf.format({ name = "null-ls" })
      else
        vim.lsp.buf.format()
      end
    end, { desc = "Format current buffer" })

    vim.diagnostic.config({ signs = false })
  end,
}
