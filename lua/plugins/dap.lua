return {
	{
		"mfussenegger/nvim-dap",
		ft = {
			"c",
			"cpp",
			"rust",
			"python",
		},
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			-- Setup DAPs
			local dap = require("dap")
			-- local mason_path = vim.fn.stdpath("data") .. "/mason/"

			-- Adapters
			-- lldb-dap: C/C++/Rust DAP
			dap.adapters.lldb = {
				type = "executable",
				command = "lldb-dap",
				name = "lldb",
				-- If using mason, probably use something like this to reference the lldb-dap executable
				-- command = mason_path .. "bin/codelldb.cmd",
			}

			-- Configurations
			-- lldb-dap
			dap.configurations.c = {
				{
					name = "Launch Executable",
					type = "lldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtEntry = true,
					args = {},
				},
			}
			-- Copy to cpp and rust
			dap.configurations.cpp = dap.configurations.c
			dap.configurations.rust = dap.configurations.c

			-- Setup keybinds
			local map = require("helpers.keys").map
			map("n", "<leader>db", "<cmd>DapToggleBreakpoint<cr>", "Toggle Breakpoint")
			map("n", "<leader>dc", "<cmd>DapContinue<cr>", "Debug Continue")
			map("n", "<leader>di", "<cmd>DapStepInto<cr>", "Step Into")
			map("n", "<leader>do", "<cmd>DapStepOver<cr>", "Step Over")
			map("n", "<leader>du", "<cmd>DapStepOut<cr>", "Step Out")
			map("n", "<leader>dk", "<cmd>lua require('dap.ui.widgets').hover()<cr>", "Debug Hover")

			-- load project dap configs
			local config_path = vim.fn.getcwd() .. "/.nvim/dap.lua"
			if vim.fn.filereadable(config_path) == 1 then
				dofile(config_path)
			end
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		lazy = true,
		dependencies = { "folke/neodev.nvim" },
		config = function()
			require("dapui").setup()

			-- Setup keybinds
			local map = require("helpers.keys").map
			map("n", "<leader>dd", "<cmd>lua require'dapui'.toggle({reset=true})<cr>", "Toggle Debug UI")
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		lazy = true,
		config = function()
			require("nvim-dap-virtual-text").setup({})
		end,
	},
	{
		-- python DAP easy setup
		"mfussenegger/nvim-dap-python",
		lazy = true,
		ft = {
			"python",
		},
		config = function()
			-- This is how we used to get debugpy's path installed by mason
			-- local debugpy_venv_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/Scripts/python.exe"
			-- require("dap-python").setup(debugpy_venv_path)

			-- If we just run setup(), dap-python will use the current python environment's installed debugpy.
			-- So you'll have to install it by yourself, either to your system or the virtual environment.
			require("dap-python").setup()
		end,
	},
}
