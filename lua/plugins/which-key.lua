return {
	{
		"folke/which-key.nvim",
		config = function()
			local wk = require("which-key")
			wk.setup()
			wk.add({
				{ "<leader>d", group = "Debugger" },
				{ "<leader>g", group = "git" },
				{ "<leader>l", group = "LSP" },
				{ "<leader>s", group = "Telescope Search" },
			})
		end,
	},
}
