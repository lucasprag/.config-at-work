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

  -- status line
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "ayu_dark",
        icons_enabled = false,
        component_separators = "",
        section_separators = "",
      },
      sections = {
        -- mode/filename | filetype/lineinfo; filename's built-in [+]/[-]
        -- markers cover lightline's readonly/modified components
        lualine_a = { "mode" },
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } }, -- relative path, like LightlineFilename
        lualine_x = { "filetype" },
        lualine_y = {},
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "location", "filetype" },
      },
    },
  },

  -- filesystem tree
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
    opts = {
      view = { width = 40, number = false },
      renderer = {
        icons = {
          show = { file = false, folder = false, folder_arrow = true, git = false },
        },
      },
    },
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
        { "<leader>bb", "<cmd>FzfLua buffers<cr>", desc = "buffers" },
        { "<leader>bd", "<cmd>BD<cr>", desc = "close" },
        { "<leader>bo", "<cmd>Bdelete hidden<cr>", desc = "close others" },
        { "<leader>bw", "<cmd>bd<cr>", desc = "close window and buffer" },
        { "<leader>bp", "<cmd>BB<cr>", desc = "previous" },
        { "<leader>bn", "<cmd>BF<cr>", desc = "next" },

        { "<leader>c", group = "code" },
        { "<leader>cc", "<Plug>(comment_toggle_linewise_current)", desc = "comment", mode = "n" },
        { "<leader>cc", "<Plug>(comment_toggle_linewise_visual)", desc = "comment", mode = "v" },
        { "<leader>c<space>", "<cmd>RemoveTrailingSpaces<cr>", desc = "remove trailing spaces" },
        { "<leader>cp", "<cmd>RemoveDebuggers<cr>", desc = "remove debuggers" },
        { "<leader>ct", "<cmd>FzfLua filetypes<cr>", desc = "change file type" },

        { "<leader>f", group = "file" },
        { "<leader>ff", "<cmd>CopyFullPath<cr>", desc = "copy full path" },
        { "<leader>fn", "<cmd>CopyFileName<cr>", desc = "copy file name" },
        { "<leader>fr", "<cmd>CopyRelativePath<cr>", desc = "copy relative path" },
        { "<leader>fm", "<cmd>FzfLua marks<cr>", desc = "marks" },

        { "<leader>g", group = "git" },
        { "<leader>gs", "<cmd>FzfLua git_status<cr>", desc = "status" },

        { "<leader>j", group = "jump" },
        { "<leader>jj", function() require("flash").jump() end, desc = "jump anywhere", mode = { "n", "x" } },
        { "<leader>jt", function() require("flash").treesitter() end, desc = "select node", mode = { "n", "x" } },

        { "<leader>p", group = "project" },
        { "<leader>pf", "<cmd>FzfLua files<cr>", desc = "files" },
        { "<leader>pt", "<cmd>NvimTreeToggle<cr>", desc = "tree" },
        { "<leader>pl", "<cmd>NvimTreeFindFile<cr>", desc = "locate on tree" },

        { "<leader>s", group = "search" },
        { "<leader>ss", "<cmd>FzfLua live_grep<cr>", desc = "search" },
        { "<leader>sh", "<cmd>TurnOffSearchHighlight<cr>", desc = "turn off highlight" },
        { "<leader>sf", "<cmd>FzfLua filetypes<cr>", desc = "filetypes" },
        { "<leader>sr", "<cmd>FzfLua oldfiles<cr>", desc = "recent files" },
        { "<leader>sw", "<cmd>FzfLua tabs<cr>", desc = "windows (tabs)" },

        { "<leader><Tab>", group = "tabs" },
        { "<leader><Tab>n", "<cmd>tabnew<cr>", desc = "new" },
        { "<leader><Tab>l", "<cmd>tabnext<cr>", desc = "next" },
        { "<leader><Tab>h", "<cmd>tabprevious<cr>", desc = "previous" },
        { "<leader><Tab>c", "<cmd>tabclose<cr>", desc = "close" },

        { "<leader>T", group = "toggles" },
        { "<leader>Tc", "<cmd>FzfLua colorschemes<cr>", desc = "colorschemes" },
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
