return {
  -- fzf binary; lazy.nvim runs the install script on update
  { "junegunn/fzf", build = "./install --all" },

  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    init = function()
      -- floating window + search at the top
      vim.g.fzf_layout = { window = { width = 0.9, height = 0.9, highlight = "Todo" } }
      vim.env.FZF_DEFAULT_OPTS = "--layout=reverse"
    end,
    config = function()
      -- overwrite Files/History with previews; Rg with toggleable preview (?)
      vim.cmd([[
        command! -bang -nargs=? -complete=dir Files
          \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('down:80%'), <bang>0)
        command! -bang History
          \ call fzf#vim#history(fzf#vim#with_preview('down:80%'))
        command! -bang -nargs=* Rg
          \ call fzf#vim#grep(
          \   'rg --column --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
          \   fzf#vim#with_preview('down:80%', '?'),
          \   <bang>0)
      ]])
      local map = vim.keymap.set
      map("n", "<C-p>", "<cmd>Files<cr>")
      map("n", ";", "<cmd>Buffers<cr>")
      map("", "s", "<cmd>Rg<cr>")      -- original used :map
      map("", "r", "<cmd>History<cr>") -- original used :map
      map("n", "<C-f>", "<cmd>Filetypes<cr>")
    end,
  },
}
