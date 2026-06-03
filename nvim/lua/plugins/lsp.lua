return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    -- lazy-load so quick edits (commit messages, scratch) skip the LSP stack;
    -- BufReadPre fires before FileType, so the first real file still attaches
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      -- servers install into nvim's data dir, not system gems/npm.
      -- No Ruby server by choice.
      ensure_installed = { "elixirls", "ts_ls" },
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      -- quiet diagnostics: signs only, no inline virtual text
      vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        underline = true,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
        callback = function(args)
          require("which-key").add({
            buffer = args.buf,
            { "<leader>l", group = "lsp" },
            { "<leader>ld", vim.lsp.buf.definition, desc = "definition" },
            { "<leader>lh", vim.lsp.buf.hover, desc = "hover" },
            { "<leader>lr", vim.lsp.buf.rename, desc = "rename" },
            { "<leader>lR", "<cmd>FzfLua lsp_references<cr>", desc = "references" },
            { "<leader>la", vim.lsp.buf.code_action, desc = "code action" },
            { "<leader>le", "<cmd>FzfLua diagnostics_document<cr>", desc = "diagnostics" },
          })
        end,
      })
    end,
  },
}
