
local colorscheme = "default"
local ok, _ = pcall(vim.cmd, "colorscheme " .. "poimandres")
if not ok then
  vim.notify("Failed to load colorscheme.")
  return
end
