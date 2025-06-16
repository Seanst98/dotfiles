-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "gruvchad",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

M.ui = {
      tabufline = {
         lazyload = false
     }
}

M.nvdash = {
  load_on_startup = true,
  header = {
"███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
"████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
"██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
"██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
"██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
"╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝", " "
  },

  buttons = {
    { txt = "󰎜  New File", keys = ":e <Fname>", cmd = "Vim open a new file"},
    { txt = "  Find File", keys = "Spc f f", cmd = "Telescope find_files" },
    { txt = "󰈚  Recent Files", keys = "Spc f o", cmd = "Telescope oldfiles" },
    { txt = "󰈭  Find Word", keys = "Spc f w", cmd = "Telescope live_grep" },
    { txt = "  Bookmarks", keys = "Spc m a", cmd = "Telescope marks" },
    { txt = "  Themes", keys = "Spc t h", cmd = "Telescope themes" },
    { txt = "  Mappings", keys = "Spc c h", cmd = "NvCheatsheet" },
    { txt = "󰑐  Restore Session", keys = "Spc w r", cmd = "Auto-session open session" },
    { txt = "  Config", keys = "DUNNO YET", cmd = "Open nvim config"},
  },
}

return M
