-- Autocmds ported from init.vim.
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- > highlight trailing whitespace
-- The buftype guard replaces the old which-key/fzf toggle workarounds:
-- plugin scratch buffers (buftype=nofile etc.) never get the match.
local ws = augroup("HighlightWhitespace", { clear = true })

local function define_hl()
  vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = "white", ctermbg = "white" })
end
define_hl()
autocmd("ColorScheme", { group = ws, callback = define_hl })

autocmd({ "BufWinEnter", "InsertLeave" }, {
  group = ws,
  callback = function()
    if vim.bo.buftype == "" then
      vim.cmd([[match ExtraWhitespace /\s\+$/]])
    end
  end,
})
autocmd("InsertEnter", {
  group = ws,
  callback = function()
    if vim.bo.buftype == "" then
      vim.cmd([[match ExtraWhitespace /\s\+\%#\@<!$/]])
    end
  end,
})
autocmd("BufWinLeave", {
  group = ws,
  callback = function() vim.fn.clearmatches() end,
})

local misc = augroup("ConfigMisc", { clear = true })

-- spell checking for markdown files
autocmd({ "BufNewFile", "BufRead" }, {
  group = misc,
  pattern = "*.md",
  callback = function() vim.opt_local.spell = true end,
})

-- comment highlighting for plain json (treesitter's json parser rejects //)
autocmd("FileType", {
  group = misc,
  pattern = "json",
  command = [[syntax match Comment +\/\/.\+$+]],
})

-- some sort of highlighting for inky templates
autocmd({ "BufNewFile", "BufRead" }, {
  group = misc,
  pattern = "*.inky",
  command = "set filetype=html",
})
