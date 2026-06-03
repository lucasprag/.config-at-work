-- Regex-based syntax plugins. This entire file is deleted in Stage 2 when
-- treesitter takes over highlighting/indent for these languages.
return {
  { "vim-ruby/vim-ruby", ft = { "ruby", "eruby" } },
  { "sheerun/vim-haml", ft = "haml" },
  { "elixir-editors/vim-elixir", ft = { "elixir", "eelixir" } },
  { "yuezk/vim-js", ft = "javascript" },
  { "HerringtonDarkholme/yats.vim" },
  { "MaxMEllon/vim-jsx-pretty", ft = { "javascript", "typescript" } },
  { "cakebaker/scss-syntax.vim", ft = "scss" },
  {
    "tpope/vim-markdown",
    ft = "markdown",
    init = function()
      -- fenced code block highlighting in markdown
      vim.g.markdown_fenced_languages = {
        "ruby", "elixir", "javascript", "html", "python", "bash=sh", "vim", "help", "sql",
      }
    end,
  },
  { "stephpy/vim-yaml", ft = { "yml", "yaml" } },
  { "dag/vim-fish", ft = "fish" },
}
