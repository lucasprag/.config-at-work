-- Non-leader mappings ported from init.vim. Leader-key mappings live in the
-- which-key spec (lua/plugins/ui.lua) so descriptions stay in one place.
local map = vim.keymap.set

-- save / quit
map({ "n", "v" }, "<C-s>", "<cmd>w<cr>")
map({ "n", "v" }, "<C-q>", "<cmd>q<cr>")
map({ "n", "v" }, "<C-a>", "<cmd>wqa<cr>")

-- previous/next buffer in the window's own history (vim-bufkill)
map("n", "<S-h>", "<cmd>BB<cr>")
map("n", "<S-l>", "<cmd>BF<cr>")

-- tabs
map("n", "<Tab>", "<cmd>tabnext<cr>")
map("n", "<S-Tab>", "<cmd>tabprevious<cr>")

-- vertical split
map("n", "<C-\\>", "<cmd>vsplit<cr>")

-- copy / cut selection to the system clipboard via pbcopy
map("v", "<C-c>", ":w !pbcopy<cr><cr>")
map("v", "<C-x>", ":!pbcopy<cr>")

-- disable cursor keys in normal mode
map("n", "<Left>", function() vim.notify("use h instead (hjkl)") end)
map("n", "<Right>", function() vim.notify("use l instead (hjkl)") end)
map("n", "<Up>", function() vim.notify("use k instead (hjkl)") end)
map("n", "<Down>", function() vim.notify("use j instead (hjkl)") end)

-- navigate splits with Alt + hjkl; at the edge, hop to the next cmux pane
-- (vim-tmux-navigator style -- see bin/cmux-navigate)
local function navigate(dir)
  return function()
    local prev = vim.fn.winnr()
    vim.cmd.wincmd(dir)
    if vim.fn.winnr() == prev then
      vim.fn.system("cmux-navigate " .. dir)
    end
  end
end
map("n", "<M-h>", navigate("h"), { silent = true })
map("n", "<M-j>", navigate("j"), { silent = true })
map("n", "<M-k>", navigate("k"), { silent = true })
map("n", "<M-l>", navigate("l"), { silent = true })
