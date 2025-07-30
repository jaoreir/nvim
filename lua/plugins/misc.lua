-- Miscelaneous fun stuff
return {
	-- Comment with haste
	-- which-key will complain about gb and gc keybinds because of this. You can ignore those warnings.
	{
		"numToStr/Comment.nvim",
		event = { "BufNewFile", "BufReadPre" },
		opts = {},
	},
	-- Move stuff with <M-j> and <M-k> in both normal and visual mode
	{
		"echasnovski/mini.move",
		event = { "BufNewFile", "BufReadPre" },
		config = function()
			require("mini.move").setup({
				-- Module mappings. Use `''` (empty string) to disable one.
				mappings = {
					-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
					left = "",
					right = "",
					down = "<M-j>",
					up = "<M-k>",

					-- Move current line in Normal mode
					line_left = "",
					line_right = "",
					line_down = "<M-j>",
					line_up = "<M-k>",
				},

				-- Options which control moving behavior
				options = {
					-- Automatically reindent selection during linewise vertical move
					reindent_linewise = true,
				},
			})
		end,
	},
	-- Better buffer closing actions. Available via the buffers helper.
	{
		"kazhala/close-buffers.nvim",
		event = { "BufNewFile", "BufReadPre" },
		opts = {
			preserve_window_layout = { "this", "nameless" },
		},
	},
	{
		"tpope/vim-sleuth",
		event = { "BufNewFile", "BufReadPre" },
	}, -- Detect tabstop and shiftwidth automatically
	"tpope/vim-surround", -- Surround stuff with the ys-, cs-, ds- commands
	{
		"windwp/nvim-autopairs",
		event = { "BufNewFile", "BufReadPre" },
		opts = {},
	},
	{
		"lukas-reineke/indent-blankline.nvim", -- indent guides
		event = { "BufNewFile", "BufReadPre" },
		main = "ibl",
		opts = {},
	},
}
