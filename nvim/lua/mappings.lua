require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")


-- HARPOON
-- Disable nvchad Leader h -- horizontal terminal window
-- Replace with Leader y

map("n", "<leader>y", function()
  require("nvchad.term").new { pos = "sp" }
end, { desc = "terminal new horizontal term" })

local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

map("n", "<leader>a", function() harpoon:list():add() end, {desc="harpoon add"})
map("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc="harpoon focus list"})
--map("n", "<leader>hd", function() harpoon:list():remove() end)

--map("n", "<C-h>", function() harpoon:list():select(1) end)
--map("n", "<C-t>", function() harpoon:list():select(2) end)
--map("n", "<C-n>", function() harpoon:list():select(3) end)
--map("n", "<C-s>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
--map("n", "<C-S-P>", function() harpoon:list():prev() end)
--map("n", "<C-S-N>", function() harpoon:list():next() end)
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
