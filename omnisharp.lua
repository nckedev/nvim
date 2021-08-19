
------- C# ----------
local pid = vim.fn.getpid()
local omnisharp_bin = ""
local root = ""
if vim.fn.has("mac") == 1 then
	omnisharp_bin = "/Users/nicke/.cache/omnisharp-vim/omnisharp-roslyn/run"
	root = "/Users/nicke"
elseif vim.fn.has("win32") == 1 then --??
	omnisharp_bin = "c:/Users/nmk41/AppData/Local/omnisharp-vim/omnisharp-roslyn/OmniSharp.exe"
	root = "c:/Users/nmk41"
else 
	omnisharp_bin = "ERROR"
end
require('lspconfig').omnisharp.setup{ 
	cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
	filetypes = { "cs", "csx" },
	root_dir = function(fname) return root end, --this obviously needs fixing
}
