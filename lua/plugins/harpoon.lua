return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({})
    local tlsconfig = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = tlsconfig.file_previewer({}),
        sorter = tlsconfig.generic_sorter({}),
      }):find()
    end

    local hp_list = harpoon:list()
    vim.keymap.set("n", "<leader>as", function() toggle_telescope(hp_list) end,
      { desc = "Search" })
    vim.keymap.set("n", "<leader>an", function() hp_list:append() end, { desc = "New index" })

    vim.keymap.set("n", "<leader>aj", function() hp_list:select(1) end, { desc = "First index" })
    vim.keymap.set("n", "<leader>ak", function() hp_list:select(2) end, { desc = "Second index" })
    vim.keymap.set("n", "<leader>al", function() hp_list:select(3) end, { desc = "Third index" })
    vim.keymap.set("n", "<leader>a;", function() hp_list:select(4) end, { desc = "Fourth index" })

    vim.keymap.set("n", "<leader>adj", function() hp_list:removeAt(1) end, { desc = "Delete first index" })
    vim.keymap.set("n", "<leader>adk", function() hp_list:removeAt(2) end, { desc = "Delete second index" })
    vim.keymap.set("n", "<leader>adl", function() hp_list:removeAt(3) end, { desc = "Delete third index" })
    vim.keymap.set("n", "<leader>ad;", function() hp_list:removeAt(4) end, { desc = "Delete fourth index" })

    vim.keymap.set("n", "<leader>ac", function() hp_list:clear() end, { desc = "Clear list" })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-z>", function() hp_list:prev() end, { desc = "Previous harpoon index" })
    vim.keymap.set("n", "<C-x>", function() hp_list:next() end, { desc = "Next harpoon index" })
  end
}
