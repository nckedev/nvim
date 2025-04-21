return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- calling `setup` is optional for customization
		require("fzf-lua").setup({
			blines = {
				prompt = " > ",
			},
			winopts = {
				height = 0.4,
				width = 1,
				row = 1,
				col = 0,
				border = "none",
				preview = {
					hidden = "hidden"
				},
			},
			preview = {
				border = "none",
				layout = "flex", -- horizontal vertical flex
				flip_columns = 100, -- nr of cols before flex layout is swapping
			},
		})
	end
}
