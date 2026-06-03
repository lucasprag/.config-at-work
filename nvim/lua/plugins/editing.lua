return {
  -- makes a map to easy move the cursor (replaced by flash.nvim in stage 3)
  {
    "easymotion/vim-easymotion",
    init = function()
      vim.g.EasyMotion_do_mapping = 0 -- disable default mappings
    end,
    config = function()
      vim.keymap.set("", "f", "<Plug>(easymotion-lineforward)")
      vim.keymap.set("", "F", "<Plug>(easymotion-linebackward)")
    end,
  },

  -- multiple cursors using C-n when selecting a word
  { "terryma/vim-multiple-cursors" },

  -- comment code (replaced by Comment.nvim in stage 3)
  {
    "scrooloose/nerdcommenter",
    init = function()
      vim.g.NERDCreateDefaultMappings = 0 -- just need the toggle
      vim.g.NERDDefaultAlign = "left"     -- delimiters flush left
      vim.g.NERDCommentEmptyLines = 0
    end,
  },

  -- :Bdelete to close all, others or hidden buffers
  { "Asheq/close-buffers.vim", cmd = "Bdelete" },

  -- :BB/:BF buffer nav in window context; :BD deletes buffer, keeps window
  {
    "qpkorr/vim-bufkill",
    init = function()
      vim.g.BufKillCreateMappings = 0
    end,
  },

  -- more pleasant editing on commit messages
  { "rhysd/committia.vim" },

  -- create files without creating dirs first (aka mkdir -p)
  { "pbrisbin/vim-mkdir" },

  -- restore cursor position and folding
  { "vim-scripts/restore_view.vim" },

  -- helps to end certain structures (Ruby's `end`, etc.)
  { "tpope/vim-endwise" },
}
