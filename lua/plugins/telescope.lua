-- Telescope fuzzy finding (all the things)
return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = vim.fn.executable("make") == 1,
            },
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-u>"] = false,
                            ["<C-d>"] = false,
                        },
                    },
                },
            })

            -- Enable telescope fzf native, if installed
            pcall(require("telescope").load_extension, "fzf")

            local map = require("helpers.keys").map

            map("n", "<c-p>", require("telescope.builtin").find_files, "Find Files")

            map("n", "<leader>sf", function()
                require("telescope.builtin").find_files({ hidden = true, no_ignore = true, no_ignore_parent = true })
            end, "Files (All)")

            map("n", "<c-f>", function()
                -- You can pass additional configuration to telescope to change theme, layout, etc.
                require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes")
                    -- .get_dropdown({
                    -- winblend = 10,
                    -- previewer = false,
                -- })
                )
            end, "Current buffer")
            map("n", "<leader><space>", require("telescope.builtin").buffers, "Buffers")
            map("n", "<leader>sr", require("telescope.builtin").oldfiles, "Recently opened")
            map("n", "<leader>sh", require("telescope.builtin").help_tags, "Help")
            map("n", "<leader>sg", require("telescope.builtin").live_grep, "Grep")
            map("n", "<leader>ss", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
            map("n", "<leader>sS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
            map("n", "<leader>sw", require("telescope.builtin").grep_string, "Current word")
            map("n", "<leader>sd", require("telescope.builtin").diagnostics, "Diagnostics")
            map("n", "<leader>sk", require("telescope.builtin").keymaps, "Search keymaps")
            map("n", "<leader>sm", require("telescope.builtin").man_pages, "Man pages")
        end,
    },
}
