return {
  {
    "saghen/blink.cmp",

    dependencies = {
      "rafamadriz/friendly-snippets",
    },

    version = "*",

    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
      },
      completion = {
        accept = { auto_brackets = { enabled = false } },
        menu = {
          border = "single",
          draw = {
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind" },
            },
          },
        },
        documentation = {
          window = { border = "single" },
        },
      },
      signature = {
        enabled = true,
        window = {
          border = "single",
          show_documentation = true,
        },
      },
      keymap = {
        ["<Tab>"] = {},
        ["<S-Tab>"] = {},
        ["<c-h>"] = { "snippet_backward" },
        ["<c-l>"] = { "snippet_forward" },
      },
      cmdline = {
        keymap = {
          ["<c-y>"] = { "accept", "fallback" },
          ["<c-p>"] = { function(cmp) cmp.select_prev({ auto_insert = false }) end, "fallback" },
          ["<c-n>"] = { function(cmp) cmp.select_next({ auto_insert = false }) end, "fallback" },
        },
      },
    },
  },
}
