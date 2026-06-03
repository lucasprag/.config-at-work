-- =============================================================================
-- Name:          Not-a-vimmer
-- File:          init.lua
-- Description:   My simplified configs for Neovim.
-- Author:        Lucas Arantes <lucasprag.com>
-- =============================================================================

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- leader must be set before plugins load
vim.g.mapleader = " "

require("config.options")
require("config.keymaps")
require("config.commands")
require("config.autocmds")

require("lazy").setup({
  spec = { { import = "plugins" } },
  install = { colorscheme = { "ayu" } },
  change_detection = { notify = false },
  rocks = { enabled = false }, -- no plugin needs luarocks
})
