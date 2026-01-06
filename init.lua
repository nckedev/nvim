--ini
--
vim.opt.title = true
-- vim.opt.background = "light"
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

vim.opt.expandtab = true
-- Make line numbers default
vim.opt.number = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- the border of popups
vim.o.winborder = "solid"

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"


-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = " ", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.opt.hlsearch = true

vim.opt.guicursor = "n-v:block-Cursor,i-ci-cr:ver20-Cursor,i-ci-cr:ver20-Cursor"



-- funkar inte ?
if vim.g.neovide then
  vim.g.neovide_floating_shadow = false
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5
  vim.g.neovide_position_animation_lenght = 0
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.experimental_layer_grouping = false
  vim.g.neovide_input_macos_option_key_is_meta = "only_left"
  -- disble scrilling animation when switching buffers
  vim.api.nvim_create_autocmd("BufLeave", {
    callback = function()
      vim.g.neovide_scroll_animation_length = 0
      vim.g.neovide_cursor_animation_length = 0
    end,
  })
  vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
      vim.fn.timer_start(70, function()
        vim.g.neovide_scroll_animation_length = 0.2
        vim.g.neovide_cursor_animation_length = 0.06
      end)
    end,
  })
end
-- vim.g.neovide_profiler = true

-- monaspace or monaspice? nerdfont
-- roboto mono
-- DejaVuSansMono Nerd Font Mono
-- vim.opt.guifont = "Liga SFMono Nerd Font:h15"
-- vim.opt.guifont = "RobotoMono_Nerd_Font_Mono:h16"
vim.opt.guifont = "JetBrainsMono_Nerd_Font:h16"
vim.opt.linespace = 1
vim.opt.pumheight = 12
vim.opt.pumwidth = 20
vim.o.ts = 4
vim.o.sw = 4

-- when launching neovide from raycast it defaults to /
if vim.g.neovide and vim.uv.cwd() == "/" then
  vim.cmd("cd ~")
end

vim.keymap.set("n", "<leader>gg", ":Gitsigns<cr>")

-- for pasting from ai
vim.keymap.set("n", "<D-v>", "p")
-- vim.keymap.set("n", "<cr>", ".")

vim.keymap.set("n", "<leader>7", ":w<cr>:so /Users/nicke/.config/nvim/init.lua<cr>")
vim.keymap.set("n", "<leader>6", ":w<cr>:color gray-base<cr>")
vim.keymap.set("n", "<leader>5", ":Inspect<cr>")
vim.keymap.set("n", "<leader>w", ":wa<cr>")

-- TODO: for rust only
vim.cmd("iab @@ #[]<left>")


local runner = require("build")
vim.keymap.set("n", "<leader>bt", runner.test, { desc = "Test" })
vim.keymap.set("n", "<leader>bb", runner.build, { desc = "Build" })
vim.keymap.set("n", "<leader>br", runner.run, { desc = "Run" })

-- opt + j or k
vim.keymap.set("n", "<M-J>", ":m .+1<CR>==", { silent = true })
vim.keymap.set("n", "<M-K>", ":m .-2<CR>==", { silent = true })
vim.keymap.set("v", "<M-J>", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<M-K>", ":m '<-2<CR>gv=gv", { silent = true })

vim.keymap.set({ "n", "x", "o" }, "<leader><leader>", "<cmd>Ctrlf<CR>")
vim.keymap.set({ "n", "x", "o" }, "<C-f>", "<cmd>Ctrlf<CR>")
vim.keymap.set("n", "<leader>ä", "<cmd>CtrlfNext<CR>")

vim.keymap.set({ "n", "o", "v" }, "q", "b")
vim.keymap.set({ "n", "o", "v" }, "<S-q>", "<S-b>")
vim.keymap.set("n", "<C-j>", "<C-d>")
vim.keymap.set("n", "<C-k>", "<C-u>")
vim.keymap.set("n", "<leader>t", vim.lsp.buf.format, { desc = "format" })
vim.keymap.set("i", "<c-0>", vim.lsp.buf.signature_help)

-- creates a print statement on a new line with the word under the cursor
vim.keymap.set("n", "<leader>dp", function()
  if vim.bo.filetype == "rust" then
    vim.cmd(":norm yiwoprintln!(\"-->> pa = {pa:?}\");")
  else
    vim.print("no mapping for filetype " .. vim.bo.filetype)
  end
end, { desc = "Debug statement" })

vim.keymap.set("n", "<leader>k", "gcc", { remap = true })
vim.keymap.set("v", "<leader>k", "gc", { remap = true })

function map_find_keys(l, r)
  for _, v in ipairs({ "f", "F", "t", "T" }) do
    vim.keymap.set({ "n", "o" }, v .. l, v .. r)
  end
end

local scope = { "i", "o", "l" }
-- remap to work with auto pairs
vim.keymap.set(scope, "<C-d>", "{", { remap = true })
vim.keymap.set(scope, "<C-k>", "}", { remap = true })
vim.keymap.set(scope, "<C-f>", "(", { remap = true })
vim.keymap.set(scope, "<C-j>", ")", { remap = true })
vim.keymap.set(scope, "<C-g>", "[", { remap = true })
vim.keymap.set(scope, "<C-h>", "]", { remap = true })
vim.keymap.set(scope, "<D-n>", "_")
vim.keymap.set(scope, "<D-m>", ":")
vim.keymap.set(scope, "<D-,>", "_")
vim.keymap.set(scope, "<D-.>", ":")

map_find_keys("<D-n>", "_")
map_find_keys("<D-m>", ":")

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<esc><cmd>nohlsearch<CR>")
vim.keymap.set("n", "<D-o>", ":lua require('oil').toggle_float('.')<CR>")
vim.keymap.set("n", "<D-O>", ":Oil<cr>")
--
-- Diagnostic keymaps
vim.keymap.set("n", "gp", vim.diagnostic.goto_prev, { desc = "Go to [P]revious diagnostic message" })
vim.keymap.set("n", "gn", vim.diagnostic.goto_next, { desc = "Go to [N]ext diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins, you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require("lazy").setup({
    -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
    "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

    -- NOTE: Plugins can also be added by using a table,
    -- with the first argument being the link and the following
    -- keys can be used to configure plugin behavior/loading/etc.
    --
    -- Use `opts = {}` to force a plugin to be loaded.
    --
    --  This is equivalent to:
    --    require('Comment').setup({})

    -- "gc" to comment visual regions/lines
    { "numToStr/Comment.nvim", opts = {} },

    -- Code comapnion AI tools
    require("codecomp"),

    require("plugins.snacks"),
    -- require("plugins.nvim-cmp"),
    require("plugins.blink"),
    require("plugins.rust"),
    -- require("plugins.smear-cursor"),
    require("plugins.lazygit"),

    {
      "nckedev/rs-macro-fmt.nvim",
      opts = {
        enabled = true,
        indent_size = 4
      },
    },

    {
      "lewis6991/gitsigns.nvim",
      opts = {
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "│" },
        },
      },
    },
    --- lualine
    {
      "nvim-lualine/lualine.nvim",
      opts = {
        options = {
          globalstatus = true,
          theme = "auto",
        },
      },
    },
    {
      'saecki/crates.nvim',
      tag = 'stable',
      config = function()
        require('crates').setup()
      end,
    },

    {                     -- Useful plugin to show you pending keybinds.
      "folke/which-key.nvim",
      event = "VimEnter", -- Sets the loading event to 'VimEnter'
      config = function() -- This is the function that runs, AFTER loading
        require("which-key").setup({ delay = 500 })

        -- Document existing key chains
        require("which-key").add({
          { "<leader>c", group = "[C]ode" },
          { "<leader>d", group = "[D]ocument" },
          { "<leader>r", group = "[R]ename" },
          { "<leader>f", group = "[F]ind" },
        })
      end,
    },
    {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup()
      end,
    },

    {
      "GustavEikaas/easy-dotnet.nvim",
      dependencies = { "nvim-lua/plenary.nvim", 'nvim-telescope/telescope.nvim', },
      config = function()
        require("easy-dotnet").setup()
      end
    },

    { -- Autoformat
      "stevearc/conform.nvim",
      opts = {
        notify_on_error = false,
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
        formatters_by_ft = {
          lua = { "stylua" },
          -- Conform can also run multiple formatters sequentially
          -- python = { "isort", "black" },
          --
          -- You can use a sub-list to tell conform to run *until* a formatter
          -- is found.
          -- javascript = { { "prettierd", "prettier" } },
        },
      },
    },
    {
      "onsails/lspkind.nvim",
    },


    {
      "slugbyte/lackluster.nvim",
    },


    -- Highlight todo, notes, etc in comments
    {
      "folke/todo-comments.nvim",
      event = "VimEnter",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = {
        signs = false,
        highlight = { after = "" },
      },
    },

    { -- Collection of various small independent plugins/modules
      "echasnovski/mini.nvim",
      config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [']quote
        --  - ci'  - [C]hange [I]nside [']quote
        require("mini.ai").setup({ n_lines = 500 })

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']
        require("mini.surround").setup()

        -- Simple and easy statusline.
        --  You could remove this setup call if you don't like it,
        --  and try some other statusline plugin
        local statusline = require("mini.statusline")
        -- set use_icons to true if you have a Nerd Font
        statusline.setup({ use_icons = vim.g.have_nerd_font })

        -- You can configure sections in the statusline by overriding their
        -- default behavior. For example, here we set the section for
        -- cursor location to LINE:COLUMN
        ---@diagnostic disable-next-line: duplicate-set-field
        statusline.section_location = function()
          return "%2l:%-2v"
        end

        -- ... and there is more!
        --  Check out: https://github.com/echasnovski/mini.nvim
      end,
    },

    { -- Highlight, edit, and navigate code
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

        ---@diagnostic disable-next-line: missing-fields
        require("nvim-treesitter.configs").setup({
          ensure_installed = { "bash", "c", "html", "lua", "markdown", "vim", "vimdoc", "rust" },
          -- Autoinstall languages that are not installed
          auto_install = true,
          highlight = { enable = true },
          indent = { enable = true },
        })

        -- There are additional nvim-treesitter modules that you can use to interact
        -- with nvim-treesitter. You should go explore a few and see what interests you:
        --
        --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
        --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
        --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
      end,
    },

    {
      "nvim-treesitter/playground",
    },
    {
      "mg979/vim-visual-multi",
    },
    {
      "cvigilv/patana.nvim",
      --- opts = {},
    },
    {
      "nckedev/gray-base.nvim",
      opts = {
        monochrome_strings = false,
        light = {
          tint = {
            hue = 35,
            saturation = 5,
          },
          colors = {
            primary = { hue = 35, lightness = 50 },
            saturation = 45,
            lightness = 55,
            strings = 85,
          },
        },
      },
    },
    require('fzf'),
    {
      "stevearc/oil.nvim",
      opts = {
        height = 100,
        float = {
          height = 100,
          padding = 20,
        },
      },
      -- Optional dependencies
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
      "nckedev/ctrlf",
      opts = {
        searchbox = "cursor_after",
        colors = {
          hint_char = { fg = "#FFFFFF", bg = "#000FF0" },
          match = { fg = "#FFFFFF", bg = "#000FF0" },
          match_closest = { fg = "#FFFFFF", bg = "#000FF0" },
        }
      }
    },
    {
      "fcancelinha/northern.nvim",
    },
    {
      "AlexvZyl/nordic.nvim",
      lazy = false,
      priority = 1000,
      config = function()
        require("nordic").load()
      end,
    },
    {
      "supermaven-inc/supermaven-nvim",
      config = function()
        require("supermaven-nvim").setup({
          keymaps = {
            accept_suggestion = "<c-7>",
            accept_word = "<c-y>",
          },
          color = {
            suggestion_color = "#8da9b0",
          }
        })
      end,
    },
    {
      "folke/trouble.nvim",
      opts = {}, -- for default options, refer to the configuration section for custom setup.
      cmd = "Trouble",
      keys = {
        {
          "<leader>xx",
          "<cmd>Trouble diagnostics toggle<cr>",
          desc = "Diagnostics (Trouble)",
        },
        {
          "<leader>xX",
          "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
          desc = "Buffer Diagnostics (Trouble)",
        },
        {
          "<leader>cs",
          "<cmd>Trouble symbols toggle focus=false<cr>",
          desc = "Symbols (Trouble)",
        },
        {
          "<leader>cl",
          "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
          desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
          "<leader>xL",
          "<cmd>Trouble loclist toggle<cr>",
          desc = "Location List (Trouble)",
        },
        {
          "<leader>xQ",
          "<cmd>Trouble qflist toggle<cr>",
          desc = "Quickfix List (Trouble)",
        },
      },
    },

    -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
    -- init.lua. If you want these files, they are in the repository, so you can just download them and
    -- put them in the right spots if you want.

    -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for kickstart
    --
    --  Here are some example plugins that I've included in the kickstart repository.
    --  Uncomment any of the lines below to enable them (you will need to restart nvim).
    --
    -- require 'kickstart.plugins.debug',
    -- require 'kickstart.plugins.indent_line',

    -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
    --    This is the easiest way to modularize your config.
    --
    --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
    --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
    -- { import = 'custom.plugins' },
  },
  {
    dev = {
      path = "~/Code",
      patterns = { "MarkMyWords.nvim" },
    },
    ui = {
      -- If you have a Nerd Font, set icons to an empty table which will use the
      -- default lazy.nvim defined Nerd Font icons otherwise define a unicode icons table
      icons = vim.g.have_nerd_font and {} or {
        cmd = "⌘",
        config = "🛠",
        event = "📅",
        ft = "📂",
        init = "⚙",
        keys = "🗝",
        plugin = "🔌",
        runtime = "💻",
        require = "🌙",
        source = "📄",
        start = "🚀",
        task = "📌",
        lazy = "💤 ",
      },
    },
  })

vim.lsp.enable({ "lua_ls" })

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "»",
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("<leader>rr", vim.lsp.buf.rename, "Rename")
    map("<D-cr>", vim.lsp.buf.code_action, "Code Action")
    map("<leader>h", vim.lsp.buf.hover, "Hover Documentation")
    map("gD", vim.lsp.buf.declaration, "Goto Declaration")

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

vim.cmd.colorscheme("gray-base")
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
