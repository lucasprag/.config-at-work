-- Ported from init.vim CONFIGS section. Only options that differ from
-- Neovim defaults (or that we want pinned explicitly) live here.
local opt = vim.opt

opt.wrap = true              -- break lines at the window edge
opt.number = true            -- show line numbers
opt.relativenumber = false
opt.showcmd = true           -- show partial commands in the last line
opt.laststatus = 2           -- always show the status line
opt.showmode = false         -- status line already shows the mode
opt.termguicolors = true     -- true color support
opt.hlsearch = true
opt.incsearch = true
opt.colorcolumn = "120"      -- guide column
opt.linespace = 2            -- extra line space for easy reading (GUI only)
opt.ignorecase = true        -- case-insensitive search...
opt.smartcase = false        --   (init.vim relied on plain ignorecase)
opt.autoindent = true
opt.ruler = true
opt.visualbell = true
opt.splitbelow = true        -- new splits below / to the right
opt.splitright = true
opt.wildignore = "*.swp,*.bak,*.pyc,*.class,*.gif,*.png,*.jpg,*.jpeg,*.lock,*.temp,!*/"
opt.timeoutlen = 300         -- make which-key fast
opt.mouse = "a"
opt.tabstop = 2              -- 2-space indentation
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoread = true          -- reload files changed outside nvim
opt.clipboard = "unnamedplus" -- yank/paste through the system clipboard
opt.spelllang = "en_us,pt_br" -- spell check in English and Portuguese

vim.g.netrw_liststyle = 3    -- tree-style netrw
