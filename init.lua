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

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
-- niklas skit
-- TODO:
-- lspsaga
-- neotest
-- csharp
-- neoclip
-- flytta rad/selection upp och ner a-s-j, a-s-k

vim.opt.guicursor = "n-v:block-Cursor,i-ci-cr:ver20-Cursor,i-ci-cr:ver20-Cursor"
--[[
require("lspconfig").rust_analyzer.setup({
  checkOnSave = true,
  procMacro = {
    enable = true,
    ignored = {
      ["async-trait"] = { "async_trait" },
      ["napi-derive"] = { "napi" },
      ["async-recursion"] = { "async_recursion" },
    },
  },
})
--]]
--[[[
require("lspconfig").gleam.setup({})
require("lspconfig").sourcekit.setup({
	cmd = {
		"/Applications/Xcode13.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp",
	},
})

require("lspconfig").csharp_ls.setup({
	cmd = { "csharp-ls" },
	root_dir = function(fname)
		return util.root_pattern("*.sln")(fname) or util.root_pattern("*.csproj")(fname)
	end,
	filetypes = { "cs" },
	init_options = {
		AutomaticWorkspaceInit = true,
	},
})
---]]

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

-- when launching neovide from raycast it defaults to /
if vim.g.neovide and vim.uv.cwd() == "/" then
  vim.cmd("cd ~")
end

-- for pasting from ai
vim.keymap.set("n", "<D-v>", "p")
vim.keymap.set("n", "<cr>", ".")

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
vim.keymap.set("n", "<leader>ä", "<cmd>CtrlfNex<CR>")

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
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<esc><cmd>nohlsearch<CR>")
vim.keymap.set("n", "<D-o>", ":lua require('oil').toggle_float('.')<CR>")
vim.keymap.set("n", "<D-O>", ":Oil<cr>")
--
-- Diagnostic keymaps
vim.keymap.set("n", "gp", vim.diagnostic.goto_prev, { desc = "Go to [P]revious diagnostic message" })
vim.keymap.set("n", "gn", vim.diagnostic.goto_next, { desc = "Go to [N]ext diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
-- vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
-- vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
-- vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

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

  require("_snacks"),
  -- require("plugins.nvim-cmp"),
  require("plugins.blink"),
  require("plugins.rust"),
  -- require("plugins.smear-cursor"),

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
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

  -- NOTE: Plugins can also be configured to run lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  {                     -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require("which-key").setup({ delay = 500 })

      -- Document existing key chains
      require("which-key").register({
        ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
        ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
        ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
        ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
        ["<leader>f"] = { name = "Find", _ = "which_key_ignore" },
        ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
      })
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    -- branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { -- If encountering errors, see telescope-fzf-native README for install instructions
        "nvim-telescope/telescope-fzf-native.nvim",

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = "make",

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      { "nvim-telescope/telescope-ui-select.nvim" },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of help_tags options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      --
      local actions = require("telescope.actions")

      require("telescope").setup({
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          file_ignore_patterns = { "node_modules/", "bin/", "obj/" },
          borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<c-?>"] = actions.which_key,
              ["<c-j>"] = actions.move_selection_next,
              ["<c-k>"] = actions.move_selection_previous,
              ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
            },
          },
          preview = {
            hide_on_startup = true,
          },
          path_display = { filename_first = { reverse_directories = false } },
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top",
            height = 0.4,
          },
        },
        pickers = {
          lsp_document_symbols = {
            previewer = false,
            layout_config = {
              height = 0.4,
              width = 0.4,
            },
            -- entry_maker = function(entry)
            -- 	local bufnr = vim.api.nvim_get_current_buf()
            -- 	local disp = vim.api.nvim_buf_get_lines(bufnr, entry.lnum - 1, entry.lnum, false)[1]
            -- 	print(vim.inspect(entry))
            -- 	print(vim.inspect(disp))
            -- 	local table = {
            -- 		value = entry,
            -- 		ordinal = "",
            -- 		display = disp or "null",
            -- 	}
            -- 	return table
            -- end,
          },
          find_files = {
            find_commmand = { "rg", "--no-config", "--files", "--sortr=modified" },
            previewer = false,
            layout_config = {
              height = 0.4,
            },
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })

      -- Enable telescope extensions, if they are installed
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      -- See `:help telescope.builtin`
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ft", ":TodoTelescope<cr>", { desc = "Find TODOs NOTEs etc" })
      vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "Find within qf" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })
      vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Find old files" })
      -- vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      -- vim.keymap.set("n", "<leader>fb", builtin.builtin, { desc = "Find telescope builtin" })
      -- vim.keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Find current word" })
      vim.keymap.set("n", "<leader>fg", function()
        builtin.live_grep({ grep_open_files = false, disable_coordinates = true })
      end, { desc = "Find with Grep" })
      vim.keymap.set("n", "<leader>fG", function()
        builtin.live_grep({ grep_open_files = true, disable_coordinates = true })
      end, { desc = "Find with Grep (open files)" })
      -- vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find diagnostics" })
      -- vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Resume last search" })
      vim.keymap.set("n", "<c-space>", function()
        builtin.buffers({ sort_lastused = true, ignore_current_buffer = true })
      end, { desc = "[ ] Find existing buffers" })

      -- vim.keymap.set(
      --   "n",
      --   "<leader>fj",
      --   builtin.current_buffer_fuzzy_find,
      --   { desc = "Fuzzily search in current buffer" }
      -- )

      -- Shortcut for searching your neovim configuration files
      vim.keymap.set("n", "<leader>fn", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
      end, { desc = "[F]ind [N]eovim files" })
      -- vim.keymap.set("n", "<leader>fp", function()
      --   builtin.find_files({ cwd = vim.fn.stdpath("data") .. "/lazy" })
      -- end, { desc = "Find Pluginfiles" })
    end,
  },

  { -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      "saghen/blink.cmp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },


      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", opts = {} },
    },
    opts = {
      servers = {
        lua_ls = {}
      }
    },
    config = function(_, opts)
      -- Brief Aside: **What is LSP?**
      --
      -- LSP is an acronym you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          -- NOTE: Remember that lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself
          -- many times.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-T>.
          map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")

          -- Find references for the word under your cursor.
          map("gr", require("telescope.builtin").lsp_references, "Goto References")

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          -- map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type Definition")

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          -- map("<leader>fs", require("telescope.builtin").lsp_document_symbols, "Find document symbols")

          -- Fuzzy find all the symbols in your current workspace
          --  Similar to document symbols, except searches over your whole project.
          -- map(
          --   "<leader>fw",
          --   require("telescope.builtin").lsp_dynamic_workspace_symbols,
          --   "Find workspace sybols"
          -- )

          -- Rename the variable under your cursor
          --  Most Language Servers support renaming across files, etc.
          map("<leader>rr", vim.lsp.buf.rename, "Rename")

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          -- map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("<D-cr>", vim.lsp.buf.code_action, "Code Action")

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap
          map("<leader>h", vim.lsp.buf.hover, "Hover Documentation")

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header
          map("gD", vim.lsp.buf.declaration, "Goto Declaration")

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
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

      local lspconfig = require('lspconfig')
      for server, config in ipairs(opts.servers) do
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP Specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        gopls = {},
        -- pyright = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        -- tsserver = {},
        --
        -- omnisharp = {
        -- 	capabilities = capabilities,
        -- 	enable_import_completion = true,
        -- 	filetypes = { "cs", "csproj", "sln", "slnx", "props", "csx", "targets" },
        -- },
        ts_ls = {},
        lua_ls = {
          -- cmd = {...},
          -- filetypes { ...},
          -- capabilities = {},
          -- settings = {
          --   Lua = {
          --     runtime = { version = "LuaJIT" },
          --     workspace = {
          --       maxPreload = 10000,
          --       preloadFileSize = 1000,
          --       checkThirdParty = false,
          --       -- Tells lua_ls where to find all the Lua files that you have loaded
          --       -- for your neovim configuration.
          --       -- library = {
          --       --   "${3rd}/luv/library",
          --       --   unpack(vim.api.nvim_get_runtime_file("", true)),
          --       -- },
          --       -- If lua_ls is really slow on your computer, you can try this instead:
          --       -- library = { vim.env.VIMRUNTIME },
          --     },
          --     completion = {
          --       callSnippet = "Replace",
          --     },
          --     -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
          --     -- diagnostics = { disable = { 'missing-fields' } },
          --   },
          -- },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu
      --   require("mason").setup()
      --
      --   -- You can add other tools here that you want Mason to install
      --   -- for you, so that they are available from within Neovim.
      --   local ensure_installed = vim.tbl_keys(servers or {})
      --   vim.list_extend(ensure_installed, {
      --     "stylua", -- Used to format lua code
      --   })
      --   -- require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
      --
      --   require("mason-lspconfig").setup({
      --     handlers = {
      --       function(server_name)
      --         local server = servers[server_name] or {}
      --         -- This handles overriding only values explicitly passed
      --         -- by the server configuration above. Useful when disabling
      --         -- certain features of an LSP (for example, turning off formatting for tsserver)
      --         server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
      --         require("lspconfig")[server_name].setup(server)
      --       end,
      --     },
      --   })
    end,
  }, -- end of lsp
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

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`
    "folke/tokyonight.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      -- vim.cmd.colorscheme("tokyonight-night")

      -- You can configure highlights by doing something like
      vim.cmd.hi("Comment gui=none")
    end,
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
        ensure_installed = { "bash", "c", "html", "lua", "markdown", "vim", "vimdoc" },
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
}, {
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

-- Lsp configs that does not use mason
-- require("lspconfig").rust_analyzer.setup({
--   checkOnSave = true,
--   procMacro = {
--     enable = true,
--     ignored = {
--       ["async-trait"] = { "async_trait" },
--       ["napi-derive"] = { "napi" },
--       ["async-recursion"] = { "async_recursion" },
--     },
--   },
-- })
require("lspconfig").lua_ls.setup({})
-- require("lspconfig").rust_analyzer.setup({})
require("lspconfig").gleam.setup({})
require("lspconfig").sourcekit.setup({
  cmd = {
    "/Applications/Xcode13.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp",
  },
})

-- vim.g.rustaceanvim = {
--   -- Plugin configuration
--   tools = {
--   },
--   -- LSP configuration
--   server = {
--     default_settings = {
--       -- rust-analyzer language server configuration
--       ['rust-analyzer'] = {
--           completion = {
--             fullFunctionSignatures = {
--               enable = true
--             }
--         }
--       },
--     },
--   },
--   -- DAP configuration
--   dap = {
--   },
-- }

vim.cmd.colorscheme("gray-base")
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
