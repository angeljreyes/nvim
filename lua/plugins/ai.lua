if not Utils.is_profile("work") then
  return {}
end

return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      panel = {
        auto_refresh = true,
      },
      suggestion = {
        enabled = true,
        trigger_on_accept = true,
        keymap = {
          dismiss = "<m-h>",
        },
      },
    },
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>C", "<cmd>CopilotChat<cr>", desc = "CopilotChat" },
    },
    opts = {
      window = {
        width = 0.35,
      },
      mappings = {
        close = {
          insert = "",
        },
      },
    },
  },
}
