return {
    "voldikss/vim-floaterm",
    config = function()
        vim.g.floaterm_borderchars = "─│─│╭╮╯╰ "
        vim.g.floaterm_titleposition = "center"

        -- Setup correct shell
        local uname = vim.loop.os_uname().sysname
        if uname == "Windows_NT" then
            vim.g.floaterm_shell = "pwsh"
        end
        if uname == "Linux" then
            vim.g.floaterm_shell = "bash"
        end

        local map = require("helpers.keys").map
        map("n", "<M-t>", "<cmd>:FloatermToggle<cr>", "Toggle Floaterm")
        map("n", "<M-c>", "<cmd>:FloatermNew<cr>", "New Floaterm")
        map("n", "<M-n>", "<cmd>:FloatermNext<cr>", "Next Floaterm")

        map("t", "<M-t>", "<cmd>:FloatermToggle<cr>", "Toggle Floaterm")
        map("t", "<M-c>", "<cmd>:FloatermNew<cr>", "New Floaterm")
        map("t", "<M-n>", "<cmd>:FloatermNext<cr>", "Next Floaterm")
        map("t", "<M-x>", "<cmd>:FloatermKill<cr><cmd>FloatermShow<cr>", "Kill Floaterm")
    end,
}
