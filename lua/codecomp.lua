vim.keymap.set({ "n", "v" }, "<leader>cc", ":CodeCompanion<cr>")
return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    -- opts = {
    --     adapters = {
    --         gemini = function()
    --             return require("codecompanion.adapters").extend("gemini", {
    --                 env = {
    --                     api_key = "no key yet ",
    --                 },
    --             })
    --         end,
    --     }
    --
    -- },

    config = function()
        require("codecompanion").setup({
            strategies = {
                chat = {
                    adapter = "gemini",
                },
                inline = {
                    adapter = "gemini",
                },
                cmd = {
                    adapter = "gemini",
                }
            },
            adapters = {
                http = {
                    gemini = function()
                        return require("codecompanion.adapters").extend("gemini", {
                            env = {
                                api_key = os.getenv("AI_KEY"),
                            },
                        })
                    end,
                }
            },
        })
    end,
}
