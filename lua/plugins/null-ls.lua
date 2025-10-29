return {
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			local ensure_installed = {
				"stylua",
			}

			local check = require("helpers.checks")

			if check.is_npm_available() then
				table.insert(ensure_installed, "prettierd")
			end

			-- if check.is_dotnet_available() then
			-- 	table.insert(ensure_installed, "csharpier")
			-- end

			if check.is_nix_available() then
				table.insert(ensure_installed, "nixpkgs_fmt")
			end

			if not check.is_on_windows() then
				table.insert(ensure_installed, "shellharden")
			end

			require("mason").setup()
			require("mason-null-ls").setup({
				ensure_installed = ensure_installed,
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim", -- null-ls replacement
		dependencies = {
			"nvim-lua/plenary.nvim", -- lua asnyc library (null-ls dependency)
		},
		config = function()
			local null_ls = require("null-ls")
			local formatting = null_ls.builtins.formatting
			local diagnostics = null_ls.builtins.diagnostics

			local sources = {
				null_ls.builtins.formatting.stylua,
			}

			local check = require("helpers.checks")

			if check.is_npm_available() then
				table.insert(sources, formatting.prettierd)
			end

			if check.is_dotnet_available() then
				table.insert(sources, formatting.csharpier)
			end

			if check.is_nix_available() then
				table.insert(sources, formatting.nixpkgs_fmt)
			end

			if not check.is_on_windows() then
				table.insert(sources, formatting.shellharden)
			end

			null_ls.setup({
				debug = false,
				sources = sources,
			})
		end,
	},
}
