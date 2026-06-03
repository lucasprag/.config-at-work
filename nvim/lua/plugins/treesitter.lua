return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master", -- frozen but stable branch; `main` rewrite can be adopted later
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "ruby", "elixir", "eex", "heex",
          "javascript", "typescript", "tsx",
          "scss", "css", "html",
          "yaml", "json", "bash", "sql", "fish",
          "python",
          "markdown", "markdown_inline",
          "lua", "vim", "vimdoc",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
