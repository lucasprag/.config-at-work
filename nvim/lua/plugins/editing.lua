return {
  -- label-based jumps; also adds labels to native f/F/t/T (char mode)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        char = { jump_labels = true }, -- f/F/t/T get jump labels, same keys as before
      },
    },
  },

  -- multiple cursors using C-n when selecting a word
  { "terryma/vim-multiple-cursors" },

  -- comment code (treesitter-aware)
  {
    "numToStr/Comment.nvim",
    opts = {
      padding = true,
      ignore = "^$", -- don't comment empty lines
    },
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
