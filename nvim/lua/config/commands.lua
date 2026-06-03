-- User commands ported from init.vim COMMANDS section.
local cmd = vim.api.nvim_create_user_command

-- I type so fast that :w becomes :W
for from, to in pairs({
  W = "w", Q = "q", WQ = "wq", Wq = "wq",
  WQa = "wqa", Wqa = "wqa", WQA = "wqa",
  Qa = "qa", QA = "qa",
}) do
  cmd(from, to, {})
end

-- remove byebug, debugger, binding.pry, puts, console.log
-- the _ avoids some waste of time http://vim.wikia.com/wiki/Power_of_g
cmd("RemoveDebuggers", [[global/byebug\|debugger\|pry\|puts\|console.log/delete_]], {})

-- remove trailing spaces, preserving cursor and last search
cmd("RemoveTrailingSpaces", function()
  local save_cursor = vim.fn.getpos(".")
  local old_query = vim.fn.getreg("/")
  vim.cmd([[%s/\s\+$//e]])
  vim.fn.setpos(".", save_cursor)
  vim.fn.setreg("/", old_query)
end, {})

-- reload / open the config
cmd("ReloadVimConfig", function()
  vim.cmd("source " .. vim.env.MYVIMRC)
  vim.cmd.edit() -- retrigger FileType for the current buffer
  vim.notify("config reloaded!")
end, {})
cmd("OpenVimConfig", "edit $MYVIMRC", {})

cmd("FormatElixirFile", "silent !mix format %", {})

cmd("ToggleLineNumbers", function() vim.o.number = not vim.o.number end, {})
cmd("ToggleRelativeLineNumbers", function() vim.o.relativenumber = not vim.o.relativenumber end, {})

cmd("CopyFullPath", function() vim.fn.setreg("+", vim.fn.expand("%:p")) end, {})
cmd("CopyRelativePath", function() vim.fn.setreg("+", vim.fn.expand("%")) end, {})
cmd("CopyFileName", function() vim.fn.setreg("+", vim.fn.expand("%:t")) end, {})

cmd("TurnOffSearchHighlight", "set nohlsearch", {})
