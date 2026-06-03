return {
  -- > colorschemes
  { "lucasprag/simpleblack" },
  {
    "ayu-theme/ayu-vim",
    lazy = false,
    priority = 1000, -- load before everything else
    config = function()
      vim.g.ayucolor = "dark"
      vim.cmd.colorscheme("ayu")
    end,
  },

  -- automatically highlight other uses of the word under the cursor
  { "RRethy/vim-illuminate" },

  -- really light and fast status line (replaced by lualine in stage 3)
  {
    "itchyny/lightline.vim",
    init = function()
      -- filename relative to the repo root when inside one
      vim.cmd([[
        function! LightlineFilename()
          let root = fnamemodify(get(b:, 'git_dir'), ':h')
          let path = expand('%:p')
          if path[:len(root)-1] ==# root
            return path[len(root)+1:]
          endif
          return expand('%')
        endfunction
      ]])
      vim.g.lightline = {
        colorscheme = "ayu_dark",
        active = {
          left = { { "mode", "paste" }, { "filename" } },
          right = { { "lineinfo" }, { "filetype" }, { "readonly", "modified" } },
        },
        inactive = {
          left = { { "filename" } },
          right = { { "lineinfo" }, { "filetype" } },
        },
        component_type = { readonly = "error" },
        component_function = { filename = "LightlineFilename" },
      }
    end,
  },

  -- filesystem tree (replaced by nvim-tree in stage 3)
  {
    "scrooloose/nerdtree",
    cmd = { "NERDTreeToggle", "NERDTreeFind" },
    init = function()
      vim.g.NERDTreeDirArrows = 1
      vim.g.NERDTreeMinimalUI = 1
      vim.g.NERDTreeShowLineNumbers = 0
      vim.g.NERDTreeWinSize = 40
    end,
  },

  -- shows keybindings in a popup when you press <leader>
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({})
      wk.add({
        { "<leader>b", group = "buffers" },
        { "<leader>ba", "<cmd>Bdelete all<cr>", desc = "close all" },
        { "<leader>bb", "<cmd>Buffers<cr>", desc = "buffers" },
        { "<leader>bd", "<cmd>BD<cr>", desc = "close" },
        { "<leader>bo", "<cmd>Bdelete hidden<cr>", desc = "close others" },
        { "<leader>bw", "<cmd>bd<cr>", desc = "close window and buffer" },
        { "<leader>bp", "<cmd>BB<cr>", desc = "previous" },
        { "<leader>bn", "<cmd>BF<cr>", desc = "next" },

        { "<leader>c", group = "code" },
        { "<leader>cc", "<Plug>NERDCommenterToggle", desc = "comment", mode = { "n", "v" } },
        { "<leader>c<space>", "<cmd>RemoveTrailingSpaces<cr>", desc = "remove trailing spaces" },
        { "<leader>cp", "<cmd>RemoveDebuggers<cr>", desc = "remove debuggers" },
        { "<leader>ct", "<cmd>Filetypes<cr>", desc = "change file type" },

        { "<leader>f", group = "file" },
        { "<leader>ff", "<cmd>CopyFullPath<cr>", desc = "copy full path" },
        { "<leader>fn", "<cmd>CopyFileName<cr>", desc = "copy file name" },
        { "<leader>fr", "<cmd>CopyRelativePath<cr>", desc = "copy relative path" },
        { "<leader>fm", "<cmd>Marks<cr>", desc = "marks" },

        { "<leader>g", group = "git" },
        { "<leader>gs", "<cmd>GFiles?<cr>", desc = "status" },

        { "<leader>j", group = "jump" },
        { "<leader>jl", "<Plug>(easymotion-lineforward)", desc = "forward" },
        { "<leader>jj", "<Plug>(easymotion-j)", desc = "down" },
        { "<leader>jk", "<Plug>(easymotion-k)", desc = "up" },
        { "<leader>jh", "<Plug>(easymotion-linebackward)", desc = "backward" },
        { "<leader>jf", "<Plug>(easymotion-w)", desc = "forward/down" },
        { "<leader>jb", "<Plug>(easymotion-b)", desc = "backward/up" },

        { "<leader>p", group = "project" },
        { "<leader>pf", "<cmd>Files<cr>", desc = "files" },
        { "<leader>pt", "<cmd>NERDTreeToggle<cr>", desc = "tree" },
        { "<leader>pl", "<cmd>NERDTreeFind<cr>", desc = "locate on tree" },

        { "<leader>s", group = "search" },
        { "<leader>ss", "<cmd>Rg<cr>", desc = "search" },
        { "<leader>sh", "<cmd>TurnOffSearchHighlight<cr>", desc = "turn off highlight" },
        { "<leader>sf", "<cmd>Filetypes<cr>", desc = "filetypes" },
        { "<leader>sr", "<cmd>History<cr>", desc = "recent files" },
        { "<leader>sw", "<cmd>Windows<cr>", desc = "windows" },

        { "<leader><Tab>", group = "tabs" },
        { "<leader><Tab>n", "<cmd>tabnew<cr>", desc = "new" },
        { "<leader><Tab>l", "<cmd>tabnext<cr>", desc = "next" },
        { "<leader><Tab>h", "<cmd>tabprevious<cr>", desc = "previous" },
        { "<leader><Tab>c", "<cmd>tabclose<cr>", desc = "close" },

        { "<leader>T", group = "toggles" },
        { "<leader>Tc", "<cmd>Colors<cr>", desc = "colorschemes" },
        { "<leader>Tn", "<cmd>ToggleLineNumbers<cr>", desc = "numbers" },
        { "<leader>Tl", "<cmd>ToggleLineNumbers<cr>", desc = "line numbers" },
        { "<leader>Tr", "<cmd>ToggleRelativeLineNumbers<cr>", desc = "relative numbers" },
        { "<leader>Tm", "<cmd>messages<cr>", desc = "messages" },

        { "<leader>v", group = "vim" },
        { "<leader>vc", "<cmd>OpenVimConfig<cr>", desc = "init.lua" },
        { "<leader>vr", "<cmd>ReloadVimConfig<cr>", desc = "reload" },
        { "<leader>vi", "<cmd>Lazy install<cr>", desc = "install" },
        { "<leader>vu", "<cmd>Lazy update<cr>", desc = "update" },
        { "<leader>vk", "<cmd>Lazy clean<cr>", desc = "clean" },

        { "<leader>w", group = "windows" },
        { "<leader>wc", "<cmd>q<cr>", desc = "close" },
        { "<leader>wo", "<cmd>only<cr>", desc = "close others" },
        { "<leader>w-", "<cmd>split<cr>", desc = "split horizontally" },
        { "<leader>w/", "<cmd>vsplit<cr>", desc = "split vertically" },
      })
    end,
  },
}
