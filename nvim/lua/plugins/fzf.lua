return {
  -- fzf binary, still managed here so the shell keeps ~/.fzf integration
  { "junegunn/fzf", build = "./install --all" },

  {
    "ibhagwan/fzf-lua",
    dependencies = { "junegunn/fzf" },
    cmd = "FzfLua",
    keys = {
      { "<C-p>", "<cmd>FzfLua files<cr>", desc = "files" },
      { ";", "<cmd>FzfLua buffers<cr>", desc = "buffers" },
      { "s", "<cmd>FzfLua live_grep<cr>", mode = { "n", "x", "o" }, desc = "ripgrep" },
      { "r", "<cmd>FzfLua oldfiles<cr>", mode = { "n", "x", "o" }, desc = "recent files" },
      { "<C-f>", "<cmd>FzfLua filetypes<cr>", desc = "filetypes" },
    },
    opts = {
      winopts = {
        width = 0.9,
        height = 0.9,
        preview = { layout = "vertical", vertical = "down:80%" },
      },
      fzf_opts = { ["--layout"] = "reverse" },
      grep = {
        rg_opts = "--column --no-heading --color=always --smart-case",
      },
    },
  },
}
