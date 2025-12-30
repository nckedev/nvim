return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,

  ---@type snacks.Config
  config = function()
    require("snacks").setup(
      {
        bigfile = { enabled = false },
        dashboard = { enabled = false },
        explorer = { enabled = false },
        indent = { enabled = false },
        input = { enabled = false },
        notifier = { enabled = false },
        quickfile = { enabled = false },
        scope = { enabled = false },
        scroll = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = false },
        lazygit = {},
        -- snacks.picker root
        picker = {
          win = {
            input = {
              keys = {
                ["<Esc>"] = { "close", mode = { "n", "i" } },
                ["<C-+>"] = "toggle_help_input",
              }
            }
          },
          prompt = " 󰜴 ",
          layout = {
            preset = "test",
            cycle = false,
            preview = false,
          },
          layouts = {
            -- I wanted to modify the ivy layout height and preview pane width,
            -- this is the only way I was able to do it
            -- NOTE: I don't think this is the right way as I'm declaring all the
            -- other values below, if you know a better way, let me know
            --
            -- Then call this layout in the keymaps above
            -- got example from here
            -- https://github.com/folke/snacks.nvim/discussions/468
            test = {
              layout = {
                box = "vertical",
                backdrop = true,
                row = -1,
                width = 0,
                height = 0.4,
                border = "top",
                title = "",
                -- title = " {title} {live} {flags}",
                title_pos = "center",
                { win = "input", height = 1, border = "bottom" },
                {
                  box = "horizontal",
                  { win = "list",    border = "none" },
                  { win = "preview", title = "{preview}", width = 0.5, border = "left" },
                },
              },
            },
          },
          formatters = {
            selected = {
              show_always = true, -- only show the selected column when there are multiple selections
              unselected = true,  -- use the unselected icon for unselected items
            },
          },

          ---@class snacks.picker.icons
          icons = {
            ui = {
              -- spaces after for some padding
              selected = "▍  ",
              unselected = "   ",
            }
          },
          sources = {
            lsp_symbols = {
              filter = {
                rust = {
                  "Class",
                  "Constructor",
                  "Enum",
                  "Field",
                  "Function",
                  "Interface",
                  "Method",
                  "Module",
                  "Namespace",
                  "Package",
                  "Property",
                  "Struct",
                  "Trait",
                  -- added from defaults
                  "Object",
                  "Constant"
                }
              }
            },
            files = {
              exclude = {
                "target/",
                "build/",
                "node_modules/",
                "*.lock"
              }
            },
            buffers = {
              current = false
            },
            git_diff = {
              layout = { preview = "main" }
            }
          }
        },
      })

    vim.keymap.set("n", "<leader>fe", Snacks.picker.explorer, { desc = "File explorer" })
    vim.keymap.set("n", "<leader>ff", Snacks.picker.files, { desc = "Files" })
    vim.keymap.set("n", "<leader>fb", Snacks.picker.pickers, { desc = "Pickers" })
    vim.keymap.set("n", "<leader>fp", Snacks.picker.projects, { desc = "Projects" })
    vim.keymap.set("n", "<leader>fj", Snacks.picker.lines, { desc = "Buffer lines" })
    vim.keymap.set("n", "<leader>fg", Snacks.picker.grep, { desc = "Grep" })
    vim.keymap.set("n", "<leader>fG", Snacks.picker.grep_buffers, { desc = "Grep buffers" })
    -- vim.keymap.set("n", "<leader>fgw", Snacks.picker.grep_word, { desc = "Grep word under cursor" })
    vim.keymap.set("n", "<C-space>", Snacks.picker.buffers, { desc = "Current open buffers" })
    -- lsp stuff
    vim.keymap.set("n", "<leader>fd", Snacks.picker.diagnostics, { desc = "Diagnostics" })
    vim.keymap.set("n", "<leader>fD", Snacks.picker.diagnostics_buffer, { desc = "Diagnostics buffer" })
    vim.keymap.set("n", "<leader>ft", function() Snacks.picker.todo_comments() end, { desc = "TODO comments" })
    vim.keymap.set("n", "gd", Snacks.picker.lsp_definitions, { desc = "Goto Definition" })
    vim.keymap.set("n", "gD", Snacks.picker.lsp_declarations, { desc = "Goto Definition" })
    vim.keymap.set("n", "<leader>fi", Snacks.picker.lsp_implementations, { desc = "Find implementations" })
    vim.keymap.set("n", "<leader>fs", Snacks.picker.lsp_symbols, { desc = "Buffer symbols" })
    vim.keymap.set("n", "<leader>fw", Snacks.picker.lsp_workspace_symbols, { desc = "workspace symbols" })
    vim.keymap.set("n", "gt", Snacks.picker.lsp_type_definitions, { desc = "Type definition" })
    vim.keymap.set("n", "<leader>fr",
      function() Snacks.picker.lsp_references({ layout = { preview = "main" }, auto_confirm = false }) end,
      { desc = "References" })
  end
}
