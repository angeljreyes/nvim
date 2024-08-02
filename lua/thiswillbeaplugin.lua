local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

local M = {}

---@return string
local function get_namespace()
  ---@type string[]
  local namespace = {}

  local dir = "%:p:h" -- Current file's parent directory
  local expanded_dir
  local prev_expanded_dir
  while true do
    prev_expanded_dir = expanded_dir
    expanded_dir = vim.fn.expand(dir)

    -- This will be true when we reach the top of the filesystem
    if expanded_dir == prev_expanded_dir then
      return vim.fn.expand("%:h:t")
    end

    for file in vim.fs.dir(expanded_dir) do
      local extension = vim.fn.fnamemodify(file, ":e")
      if extension == "csproj" then
        table.insert(namespace, 1, vim.fn.fnamemodify(file, ":r"))
        return table.concat(namespace, ".")
      end
    end

    table.insert(namespace, vim.fn.expand(dir .. ":t"))
    dir = dir .. ":h"
  end
end

local function get_classname()
  -- The pattern gets the filename until the first dot, as opposed to
  -- the last dot, which is what :r does
  -- Class.razor.cs
  --   :r       ->  Class.razor
  --   pattern  ->  Class
  return vim.fn.expand([[%:t:s?\(\w\+\).*?\1?]])
end

function M.setup()
  ls.add_snippets("cs", {
    s("fclass", {
      t("namespace "),

      i(1),
      f(get_namespace, 1),

      t({";", "", ""}),

      i(2, "public"),
      t(" class "),

      i(3),
      f(get_classname, 3),

      t({"", "{", "\t"}),
      i(0),
      t({"", "}"})
    })
  })
end

return M
