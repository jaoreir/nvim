-- Git related plugins
return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufNewFile", "BufReadPre" },
        opts = {},
    },
    {
        "akinsho/git-conflict.nvim",
        commit = "2957f74",
        config = function()
            require("git-conflict").setup({
                default_mappings = {
                    ours = "co",
                    theirs = "ct",
                    none = "c0",
                    both = "cb",
                    next = "cn",
                    prev = "cp",
                },
            })
        end,
    },
    {
        "tpope/vim-fugitive",
        config = function()
            local map = require("helpers.keys").map
            map("n", "<leader>ga", "<cmd>Git add %<cr>", "Stage the current file")
            map("n", "<leader>gb", "<cmd>Git blame<cr>", "Show the blame")
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local map = require("helpers.keys").map
            require("telescope").load_extension("lazygit")
            map("n", "<leader>gg", "<cmd>LazyGit<cr>", "Open LazyGit")
        end,
    },
}
