-- general options
local opts = {
	history = 1000,
	clipboard = "unnamedplus",
	softtabstop = 4,
	tabstop = 4,
	shiftwidth = 4,
	expandtab = true,
	smartindent = true,
	number = true,
	relativenumber = true,
	lazyredraw = true,
	termguicolors = true,
}

-- inject options
for opt, val in pairs(opts) do
	vim.o[opt] = val
end

-- colors
local colorscheme = require("helpers.colorscheme")
vim.cmd.colorscheme(colorscheme)

if vim.g.neovide then
	vim.o.guifont = "Iosevka Nerd Font:h12"
	vim.g.neovide_cursor_animation_length = 0.02
	vim.g.neovide_scroll_animation_length = 0.1
	vim.g.neovide_transparency = 1.0
end
