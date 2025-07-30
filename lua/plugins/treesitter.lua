-- Highlight, edit, and navigate code
return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			pcall(require("nvim-treesitter.install").update({
				with_sync = true,
			}))
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
		},
		config = function()
			require("nvim-treesitter.install").prefer_git = true
			local ensure_installed = {
				"lua",
				"vimdoc",
				"vim",
				"bash",
			}

			local check = require("helpers.checks")

			if check.is_c_available() then
				table.insert(ensure_installed, "c")
				table.insert(ensure_installed, "cpp")
			end

			if check.is_python_available() then
				table.insert(ensure_installed, "python")
			end

			if check.is_npm_available() then
				table.insert(ensure_installed, "html")
				table.insert(ensure_installed, "css")
				table.insert(ensure_installed, "javascript")
				table.insert(ensure_installed, "typescript")
				table.insert(ensure_installed, "tsx")
			end

			if check.is_dotnet_available() then
				table.insert(ensure_installed, "c_sharp")
			end

			if check.is_go_available() then
				table.insert(ensure_installed, "go")
			end

			if check.is_cargo_available() then
				table.insert(ensure_installed, "rust")
			end

			if check.is_nim_available() then
				table.insert(ensure_installed, "nim")
			end

			require("nvim-treesitter.configs").setup({
				-- Add languages to be installed here that you want installed for treesitter
				ensure_installed = ensure_installed,

				autotag = { enable = true },
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
					disable = { "python" },
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<c-space>",
						node_incremental = "<c-space>",
						scope_incremental = "<c-s>",
						node_decremental = "<c-backspace>",
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
				},
			})
		end,
	},
}
