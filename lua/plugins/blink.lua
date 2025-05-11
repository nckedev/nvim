local function is_rustanalyzer(ctx)
  if ctx.item.client_name == "rust-analyzer" then
    return true
  end
  return false
end

local function has_context_details(ctx)
  local c = ctx.item.detail or ""
  if c ~= "" then
    return true
  end
  return false
end

local function is_func_or_method(ctx)
  if ctx.item.kind == "Function" or ctx.item.kind == "Method" then
    return true
  end
  return false
end

local function needs_import(ctx)
  return false
end


local r = {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  -- dependencies = { 'rafamadriz/friendly-snippets' },

  -- use a release tag to download pre-built binaries
  version = '1.*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = 'super-tab',
      ["<cr>"] = { "select_and_accept", "fallback" },
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = {
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
      list = {
        selection = { preselect = true, auto_insert = false }
      },
      menu = {
        draw = {
          align_to = "label",
          -- columns = { { "kind_icon", "label_detail", gap = 1 }, { "label_description" } },
          columns = { { "kind_icon", "label", "right_col", gap = 1 }, },
          treesitter = { "lsp" },
          components = {
            -- you can make custom columns!
            test = { text = function(ctx) return ctx.idx .. "" end },
            label = {
              -- handle type for variable and macro! for macro
              -- handle snippets
              -- truncate function sibnature if  use import
              -- concat deteails if function or method
              -- handle async const extern "C" and unsafe
              --
              -- (as ..)
              -- (alias ..)
              -- (use ..)
              ellipsis = true,
              width = {
                min = 20,
                max = 50,
                fill = true
              },
            },
            -- experimental
            label_extra = {
              ellipsis = false,
              width = {
                fill = true,
                max = 20
              },
              text = function(ctx)
                local context_details = ctx.item.detail or ""
                -- vim.print(ctx)
                if is_rustanalyzer(ctx) and has_context_details(ctx) and is_func_or_method(ctx) and not needs_import(ctx) then
                  local s, _ = string.find(context_details, "%(")
                  local new_details = string.sub(context_details, s or 0)
                  vim.print(new_details)
                  return new_details or ""
                else
                  return ""
                end
              end

              --   if string.find(ctx.item.detail or "", "^fn") ~= nil and string.find(ctx.label, "test") ~= nil then
              --   vim.print(vim.inspect(ctx))
              -- end
              --   return ctx.label .. (ctx.item.detail  or "" )
              -- end,
            },
            right_col = {
              width = {
                max = 20,
              },
              text = function(ctx)
                return ctx.item.detail or ""
              end,
              highlight = function()
                return "Comment"
              end
            }
          }
        },
      },
    },
    signature = { enabled = false },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets' },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}


-- treesitter higlighting stolen from blinks core
-- needed for higlighting custom colums that will otherwise be ignored when treesitter is set to 'lsp'
-- needs a way to calculate the offset in the capture groups if the line is not directly at the start
local function test_treesitter(str)
  local ret        = {}
  local ok, parser = pcall(vim.treesitter.get_string_parser, str, "rust")
  if not ok then return ret end

  parser:parse(true)

  parser:for_each_tree(function(tstree, tree)
    if not tstree then return end
    local query = vim.treesitter.query.get(tree:lang(), 'highlights')
    -- Some injected languages may not have highlight queries.
    if not query then return end

    for capture, node in query:iter_captures(tstree:root(), str) do
      local _, start_col, _, end_col = node:range()

      ---@type string
      local name = query.captures[capture]
      if name ~= 'spell' then
        ret[#ret + 1] = {
          start_col,
          end_col,
          group = '@' .. name .. '.' .. 'rust',
        }
      end
    end
  end)
  return ret
end

vim.print(test_treesitter("fn test(&str, i32) -> u32"))

return r
