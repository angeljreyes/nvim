return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    })

    ---@param index integer index to select a list item
    ---@return function
    local function sel(index)
      return function() harpoon:list():select(index) end
    end

    vim.keymap.set("n", "<leader>as", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Search" })
    vim.keymap.set("n", "<leader>an", function() harpoon:list():add() end, { desc = "New index" })

    vim.keymap.set("n", "<leader>aj", sel(1), { desc = "First index" })
    vim.keymap.set("n", "<leader>ak", sel(2), { desc = "Second index" })
    vim.keymap.set("n", "<leader>al", sel(3), { desc = "Third index" })
    vim.keymap.set("n", "<leader>a;", sel(4), { desc = "Fourth index" })

    vim.keymap.set("n", "<leader>ac", function() harpoon:list():clear() end, { desc = "Clear list" })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "[a", function() harpoon:list():prev() end, { desc = "Previous harpoon index" })
    vim.keymap.set("n", "]a", function() harpoon:list():next() end, { desc = "Next harpoon index" })
  end,
}
