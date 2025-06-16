require("nvchad.configs.lspconfig").defaults()

-- local servers = { "html", "cssls" }
-- vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 


local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "zls" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

-- local cmp = require "cmp"
-- cmp.setup({
-- 	sorting = {
-- 		comparators = {
-- 			cmp.config.compare.offset,
-- 			cmp.config.compare.exact,
-- 			cmp.config.compare.score,
-- 			cmp.config.compare.recently_used,
-- 			require("cmp-under-comparator").under,
-- 			cmp.config.compare.kind,
--     },
--   },
-- })

-- Diagnostics
--vim.diagnostic.config({
  -- signs = { priority = 9999 },
  --underline = true,
  --update_in_insert = false, -- false so diags are updated on InsertLeave
  --virtual_text = { current_line = true, severity = { min = "INFO", max = "WARN" } },
  --virtual_lines = { current_line = true, severity = { min = "ERROR" } },
  --severity_sort = true,
  --float = {
    --focusable = false,
    --style = "minimal",
    --border = "rounded",
    --source = true,
    --header = "",
  --},
--})
vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = { current_line = true },
  underline = true,
  update_in_insert = false
})

local og_virt_text
local og_virt_line
vim.api.nvim_create_autocmd({ 'CursorMoved', 'DiagnosticChanged' }, {
  group = vim.api.nvim_create_augroup('diagnostic_only_virtlines', {}),
  callback = function()
    if og_virt_line == nil then
      og_virt_line = vim.diagnostic.config().virtual_lines
    end

    -- ignore if virtual_lines.current_line is disabled
    if not (og_virt_line and og_virt_line.current_line) then
      if og_virt_text then
        vim.diagnostic.config({ virtual_text = og_virt_text })
        og_virt_text = nil
      end
      return
    end

    if og_virt_text == nil then
      og_virt_text = vim.diagnostic.config().virtual_text
    end

    local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1

    if vim.tbl_isempty(vim.diagnostic.get(0, { lnum = lnum })) then
      vim.diagnostic.config({ virtual_text = og_virt_text })
    else
      vim.diagnostic.config({ virtual_text = false })
    end
  end
})

vim.api.nvim_create_autocmd('ModeChanged', {
  group = vim.api.nvim_create_augroup('diagnostic_redraw', {}),
  callback = function()
    pcall(vim.diagnostic.show)
  end
})
