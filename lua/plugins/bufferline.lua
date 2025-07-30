-- See current buffers at the top of the editor
return {
	{
		"willothy/nvim-cokeline", -- alternative bufferline that has better unique names
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for v0.4.0+
			"nvim-tree/nvim-web-devicons", -- If you want devicons
			"stevearc/resession.nvim", -- Optional, for persistent history
		},
		config = function()
			local lazy = require("cokeline.lazy")
			local state = lazy("cokeline.state")
			local sliders = lazy("cokeline.sliders")
			local hlgroups = lazy("cokeline.hlgroups")

			require("cokeline").setup({
				-- The default highlight group values.
				-- The `fg`, `bg`, and `sp` keys are either colors in hexadecimal format or
				-- functions taking a `buffer` parameter and returning a color in
				-- hexadecimal format. Style attributes work the same way, but functions
				-- should return boolean values.
				default_hl = {
					-- default: `ColorColumn`'s background color for focused buffers,
					-- `Normal`'s foreground color for unfocused ones.
					fg = function(buffer)
						local hlgroups = require("cokeline.hlgroups")
						return buffer.is_focused and hlgroups.get_hl_attr("TabLineSel", "fg")
							or hlgroups.get_hl_attr("ColorColumn", "fg")
					end,

					-- default: `Normal`'s foreground color for focused buffers,
					-- `ColorColumn`'s background color for unfocused ones.
					-- default: `Normal`'s foreground color.
					bg = function(buffer)
						local hlgroups = require("cokeline.hlgroups")
						return buffer.is_focused and hlgroups.get_hl_attr("ColorColumn", "bg")
							or hlgroups.get_hl_attr("Normal", "bg")
					end,

					-- default: unset.
					sp = nil,

					bold = nil,
					italic = nil,
					underline = nil,
					undercurl = nil,
					strikethrough = nil,
				},

				-- The highlight group used to fill the tabline space
				fill_hl = "Normal",

				-- Components
				components = {
					{
						text = function(buffer)
							return " " .. buffer.devicon.icon
						end,
						fg = function(buffer)
							return buffer.devicon.color
						end,
					},
					{
						text = function(buffer)
							return buffer.unique_prefix
						end,
						fg = function()
							return hlgroups.get_hl_attr("Comment", "fg")
						end,
						italic = true,
					},
					{
						text = function(buffer)
							return buffer.filename
						end,
						underline = function(buffer)
							return buffer.is_focused
						end,
					},
					{
						text = function(buffer)
							local d = buffer.diagnostics
							local result = ""
							if d.errors > 0 then
								result = result .. "  " .. d.errors
							end
							return result
						end,
						fg = function()
							return hlgroups.get_hl_attr("ErrorMsg", "bg")
						end,
					},
					{
						text = function(buffer)
							local d = buffer.diagnostics
							local result = ""
							if d.warnings > 0 then
								result = result .. "  " .. d.warnings
							end
							return result
						end,
						fg = function()
							return hlgroups.get_hl_attr("Search", "fg")
						end,
					},
					-- {
					-- 	text = function(buffer)
					-- 		local d = buffer.diagnostics
					-- 		local result = ""
					-- 		if d.infos > 0 then
					-- 			result = result .. "  " .. d.infos
					-- 		end
					-- 		return result
					-- 	end,
					-- 	fg = function()
					-- 		return hlgroups.get_hl_attr("Conceal", "fg")
					-- 	end,
					-- },
					{
						text = " ",
					},
					{
						text = function(buffer)
							if buffer.is_modified then
								return ""
							end
							if buffer.is_hovered then
								return "󰅙"
							end
							return "󰅖"
						end,
						on_click = function(_, _, _, _, buffer)
							buffer:delete()
						end,
					},
					{
						text = " ",
					},
				},

				tabs = {
					placement = "right",
					components = {
						{
							text = function(tab)
								-- print("--- tab info ---")
								-- for i, v in pairs(tab) do
								-- 	print(tostring(i) .. ": " .. tostring(v))
								-- end
								return " " .. tab.index .. " "
							end,
							bg = function(tab)
								local hlgroups = require("cokeline.hlgroups")
								return tab.is_active and hlgroups.get_hl_attr("ColorColumn", "bg")
									or hlgroups.get_hl_attr("Normal", "bg")
							end,
						},
					},
				},
			})
		end,
	},
}
