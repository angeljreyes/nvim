---@class (exact) NvimConfig.LanguageServer
---@field settings? table
---@field enabled? boolean
---@field filetypes? string[]
---@field init_options? table

---@module "snacks"

local on_lsp_attach = function(client, bufnr)
  local map = function(mode, keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  map("n", "<leader>cr", vim.lsp.buf.rename, "Code Rename")
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
  map("i", "<c-.>", vim.lsp.buf.code_action, "Code Action")

  map("n", "gd", Snacks.picker.lsp_definitions, "Go to Definition")
  map("n", "gr", Snacks.picker.lsp_references, "Go to References")
  map("n", "gI", Snacks.picker.lsp_implementations, "Go to Implementation")
  map("n", "<leader>sT", Snacks.picker.lsp_type_definitions, "Search type definitions")
  map("n", "<leader>sS", Snacks.picker.lsp_symbols, "Search document symbols")
  map("n", "<leader>sW", Snacks.picker.lsp_workspace_symbols, "Search workspace symbols")

  -- See `:help K` for why this keymap
  map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
  map("n", "<c-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace Add Folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder")
  map(
    "n",
    "<leader>wl",
    function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
    "Workspace List Folders"
  )

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(
    bufnr,
    "Format",
    function(_) vim.lsp.buf.format() end,
    { desc = "Format current buffer with LSP" }
  )
end

return {
  { "j-hui/fidget.nvim", config = true },

  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_pending = " ",
          package_installed = " ",
          package_uninstalled = " ",
        },
      },
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",

    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "saghen/blink.cmp",
    },

    config = function()
      ---@type { [string]: NvimConfig.LanguageServer }
      local servers = {
        rust_analyzer = { enabled = Utils.is_profile("home") },
        omnisharp = {
          filetypes = { "csx", "cs" },
          settings = {
            RoslynExtensionsOptions = {
              EnableImportCompletion = true,
            },
          },
        },
        ts_ls = {},
        html = {},
        angularls = {
          enabled = Utils.is_profile("home"),
          filetypes = { "html", "angular" },
        },
        tailwindcss = {
          filetypes = { "html", "angular" },
          init_options = {
            userLanguages = {
              angular = "html",
            },
          },
        },
        jsonls = {},
        clangd = { enabled = Utils.is_profile("home") },
        pyright = {},
        ruff = {},
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        },
      }

      for name, server in pairs(servers) do
        if server.enabled == false then
          servers[name] = nil
        end
      end

      -- Ensure the servers above are installed
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = true,
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          local server = servers[server_name]

          if server == nil then
            return
          end

          require("lspconfig")[server_name].setup({
            capabilities = require("blink.cmp").get_lsp_capabilities(),
            on_attach = on_lsp_attach,
            settings = server.settings or {},
            filetypes = server.filetypes,
            init_options = server.init_options,
          })
        end,
      })

      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = false,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
      })

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
    end,
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },

  {
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

      vim.keymap.set({ "n", "x" }, "<leader>cf", function()
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
  },

  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
}
