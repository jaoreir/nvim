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
			-- "nvim-treesitter/nvim-treesitter-textobjects",
			-- "windwp/nvim-ts-autotag",
		},
		config = function()
			require("nvim-treesitter.install").prefer_git = true

			-- Make list of parsers you want to install
			local file_types = {
				"lua",
				"vimdoc",
				"vim",
				"bash",
				"python",
				"html",
				"css",
				"javascript",
			}

			local check = require("helpers.checks")

			if check.is_c_available() then
				table.insert(file_types, "c")
				table.insert(file_types, "cpp")
			end

			if check.is_npm_available() then
				table.insert(file_types, "typescript")
				table.insert(file_types, "tsx")
			end

			if check.is_dotnet_available() then
				table.insert(file_types, "c_sharp")
			end

			if check.is_go_available() then
				table.insert(file_types, "go")
			end

			if check.is_cargo_available() then
				table.insert(file_types, "rust")
			end

			if check.is_nim_available() then
				table.insert(file_types, "nim")
			end

			if check.is_nix_available() then
				table.insert(file_types, "nix")
			end

			-- Install parsers in list
			require("nvim-treesitter").install(file_types)

			-- Setup treesitter to start on the specific filetypes
			vim.api.nvim_create_autocmd("FileType", {
				pattern = file_types,
				callback = function()
					-- syntax highlighting, provided by Neovim
					vim.treesitter.start()

					-- indentation, provided by nvim-treesitter
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

					-- -- folds, provided by Neovim (Disabled for now)
					-- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					-- vim.wo.foldmethod = "expr"
				end,
			})
		end,
	},
}
