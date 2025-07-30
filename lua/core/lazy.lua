-- don't load plugins if used by vscode
if not vim.g.vscode then
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath })
    end
    vim.opt.rtp:prepend(lazypath)

    local ok, lazy = pcall(require, "lazy")
    if not ok then
        return
    end

    local keys = require("helpers.keys")

    -- We have to set the leader key here for lazy.nvim to work
    keys.set_leader(" ")

    lazy.setup("plugins")

    keys.map("n", "<leader>L", lazy.show, "Show Lazy")
end
