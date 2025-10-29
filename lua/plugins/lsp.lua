-- LSP Configuration & Plugins
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim", -- installer for LSPs, formatters etc
			"williamboman/mason-lspconfig.nvim", -- mason + lspconfig
			{
				"j-hui/fidget.nvim", -- notification and progress engine (at lower left)
				tag = "legacy",
				event = "LspAttach",
			},
			"folke/neodev.nvim", -- neovim config dev helper
			"RRethy/vim-illuminate", -- highlighter
			"hrsh7th/cmp-nvim-lsp", -- auto completion engine
			"Decodetalkers/csharpls-extended-lsp.nvim", -- CSharp decompilation support
			{
				"SmiteshP/nvim-navbuddy", -- Navigation
				dependencies = {
					"SmiteshP/nvim-navic",
					"MunifTanjim/nui.nvim",
				},
				opts = { lsp = { auto_attach = true } },
			},
			{ -- Trouble: Diagnostic listing
				"folke/trouble.nvim",
				event = { "BufNewFile", "BufReadPre" },
				dependencies = { "nvim-tree/nvim-web-devicons" },
				opts = {},
				cmd = "Trouble",
				keys = {
					{
						"<leader>lx",
						"<cmd>Trouble diagnostics toggle focus=true<cr>",
						desc = "Diagnostics (Trouble)",
					},
					{
						"<leader>lX",
						"<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
						desc = "Buffer Diagnostics (Trouble)",
					},
					{
						"<leader>ll",
						"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
						desc = "LSP Definitions / references / ... (Trouble)",
					},
					{
						"<leader>lL",
						"<cmd>Trouble loclist toggle<cr>",
						desc = "Location List (Trouble)",
					},
					{
						"<leader>lQ",
						"<cmd>Trouble qflist toggle<cr>",
						desc = "Quickfix List (Trouble)",
					},
				},
			},
		},
		config = function()
			-- List of all LSP configurations
			local config_list = {
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								library = {
									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									[vim.fn.stdpath("config") .. "/lua"] = true,
								},
							},
						},
					},
				},
				taplo = {},
			}

			local check = require("helpers.checks")

			if check.is_c_available() then
				config_list["clangd"] = {}
				config_list["cmake"] = {}
			end

			if check.is_python_available() then
				-- config_list["pyright"] = {}
				config_list["pylsp"] = {
					plugins = {
						pycodestyle = { enabled = false },
					},
				}
				config_list["ruff"] = {}
			end

			if check.is_npm_available() then
				config_list["html"] = {}
				config_list["cssls"] = {}
				config_list["ts_ls"] = {}
			end

			if check.is_dotnet_available() then
				config_list["csharp_ls"] = {
					-- csharp decompilation support
					handlers = {
						["textDocument/definition"] = require("csharpls_extended").handler,
						["textDocument/typeDefinition"] = require("csharpls_extended").handler,
					},
				}
			end

			if check.is_go_available() then
				config_list["gopls"] = {}
			end

			if check.is_cargo_available() then
				config_list["rust_analyzer"] = {}
			end

			if check.is_nim_available() then
				config_list["nimls"] = {}
			end

			if check.is_on_windows() then
				config_list["powershell_es"] = {}
			end

			if check.is_nix_available() then
				config_list["nil_ls"] = {}
			end

			if check.is_java_available() then
				config_list["jdtls"] = {}
			end

			local funcs = require("helpers.funcs")

			-- Set up Mason before anything else
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = funcs.keys(config_list),
				automatic_installation = true,
			})

			-- Quick access via keymap
			require("helpers.keys").map("n", "<leader>M", "<cmd>Mason<cr>", "Show Mason")

			-- Neodev setup before LSP config
			require("neodev").setup({
				-- library = { plugins = { "nvim-dap-ui" }, types = true },
			})

			-- Turn on LSP status information
			require("fidget").setup()

			-- Diagnostic config
			local diagnostic_config = {
				virtual_text = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = "󰟶 ",
						[vim.diagnostic.severity.INFO] = " ",
					},
				},
				update_in_insert = true,
				underline = true,
				severity_sort = true,
				float = {
					focusable = true,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			}
			vim.diagnostic.config(diagnostic_config)

			-- This function gets run when an LSP connects to a particular buffer.
			local on_attach = function(client, bufnr)
				-- Setup keybinds
				local lsp_map = require("helpers.keys").lsp_map

				lsp_map("<leader>lr", vim.lsp.buf.rename, bufnr, "Rename symbol")
				lsp_map("<leader>la", vim.lsp.buf.code_action, bufnr, "Code action")
				lsp_map("<leader>ld", vim.lsp.buf.type_definition, bufnr, "Type definition")
				lsp_map("<leader>ls", require("telescope.builtin").lsp_document_symbols, bufnr, "Document symbols")

				lsp_map("gd", vim.lsp.buf.definition, bufnr, "Goto Definition")
				lsp_map("gr", require("telescope.builtin").lsp_references, bufnr, "Goto References")
				lsp_map("gI", vim.lsp.buf.implementation, bufnr, "Goto Implementation")
				lsp_map("K", vim.lsp.buf.hover, bufnr, "Hover Documentation")
				lsp_map("gD", vim.lsp.buf.declaration, bufnr, "Goto Declaration")

				-- Create a command `:Format` local to the LSP buffer
				vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
					vim.lsp.buf.format()
				end, {
					desc = "Format current buffer with LSP",
				})

				lsp_map("<M-S-f>", "<cmd>Format<cr>", bufnr, "Format")
				lsp_map("<M-f>", "<cmd>Format<cr>", bufnr, "Format")

				-- Attach and configure vim-illuminate
				require("illuminate").on_attach(client)

				-- Attach and configure navic
				if client.server_capabilities.documentSymbolProvider then
					local navic = require("nvim-navic")
					navic.attach(client, bufnr)
				end
				lsp_map("<leader>ln", "<cmd>:Navbuddy<cr>", bufnr, "Open Navbuddy")
			end

			-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			-- Setup each LSP
			local default_config = {
				on_attach = on_attach,
				capabilities = capabilities,
			}
			for lsp_name, lsp_config in pairs(config_list) do
				local merged_config = funcs.merge(default_config, lsp_config)
				vim.lsp.config(lsp_name, merged_config)
			end
		end,
	},
}
