call plug#begin()
	Plug 'nckedev/ctrlf'

	Plug 'airblade/vim-gitgutter'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-fugitive'

	Plug 'OmniSharp/omnisharp-vim'
	Plug 'kabouzeid/nvim-lspinstall'
	Plug 'hrsh7th/nvim-compe'
	Plug 'neovim/nvim-lspconfig'
	Plug 'glepnir/lspsaga.nvim'
	Plug 'folke/trouble.nvim'
	Plug 'dense-analysis/ale'

	Plug 'mfussenegger/nvim-dap'
	Plug 'rcarriga/nvim-dap-ui'

	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}
	Plug 'nvim-treesitter/playground'
	Plug 'arcticicestudio/nord-vim'
	Plug 'nanotech/jellybeans.vim'
	Plug 'morhetz/gruvbox'
	Plug 'chriskempson/base16-vim'

	Plug 'easymotion/vim-easymotion'
	"Plug 'ggandor/lightspeed.nvim'
	Plug 'phaazon/hop.nvim'

	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
call plug#end()

color nord
language en_US
syntax on
filetype plugin indent on
set autochdir
set cursorline
set scrolloff=5
set signcolumn=yes
set number
set termguicolors
set hidden
set nohlsearch
set ignorecase
set smartcase
set nobackup
set noswapfile
set tabstop=4
set shiftwidth=4
set smarttab
set splitbelow splitright
set fillchars+=vert:.

set completeopt=menuone,noinsert

autocmd BufRead,BufNewFile *.csx set filetype=cs

luafile ~/.config/nvim/debugger.lua

let g:EasyMotion_do_mapping = 0
let g:mapleader = "\<Space>"

if has('mouse')
	set mouse=a
endif
lua theme = require('telescope.themes').get_ivy { shorten_path=true }
nnoremap <leader>r <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <leader>k <cmd>lua vim.lsp.buf.hover()<cr>

nnoremap <leader>dl <cmd>Lspsaga show_line_diagnostics<cr>
nnoremap <leader>ds <cmd>Lspsaga signature_help<cr>
nnoremap <leader>d <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>
nnoremap <leader>dn <cmd>lua vim.lsp.diagnostic.goto_next()<cr>
nnoremap <leader>dp <cmd>lua vim.lsp.diagnostic.goto_prev()<cr>

nnoremap <leader>gt <cmd>TroubleToggle<cr>
nnoremap <leader>gd <cmd>lua vim.lsp.buf.definition()<cr>
"nnoremap <leader>gr <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <leader>gr <cmd>Telescope lsp_references theme=get_ivy<cr>
nnoremap <leader>gi <cmd>lua vim.lsp.buf.implementation()<cr>
nnoremap <leader>ca <cmd>Telescope lsp_code_actions theme=get_cursor<cr>
"nnoremap <leader>ca <cmd>lua vim.lsp.buf.code_action() theme=get_ivy<cr>
"nnoremap <leader>ca <cmd> lua require'telescope.builtin'.lsp_code_actions{}<cr>
nnoremap <leader>t <cmd>lua vim.lsp.buf.formatting()<cr>

nnoremap <leader>fr <cmd>Telescope registers<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fb <cmd>Telescope file_browser<cr>
nnoremap <leader>4 :w<cr>:!rdmd %<cr>
nnoremap <leader>5 :w<cr>:!rdmd -unittest %<cr>
"map <C-f> <Plug>(easymotion-sn)

autocmd FileType cs nmap <silent> <buffer> <leader>h <Plug>(omnisharp_signature_help)
autocmd FileType cs nmap <silent> <buffer> <leader>gd <Plug>(omnisharp_go_to_defenition)
autocmd FileType cs nmap <f5> :!dotnet script %<cr>

nnoremap <c-f> <cmd>Ctrlf<cr>
nnoremap <c-space> <cmd>CtrlfNext<cr>

nnoremap Q q
nnoremap qw <cmd>Telescope lsp_workspace_symbols theme=get_ivy previewer=false <cr>
nnoremap qq <cmd>Telescope buffers theme=get_ivy previewer=false show_all_buffers=false sort_lastused=true ignore_current_buffer=true<cr>
nnoremap qa <cmd>Telescope builtin theme=get_ivy previewer=false <cr>
nnoremap qg <cmd>Telescope live_grep theme=get_ivy previewer=false short_path=2 <cr>
nnoremap qe <cmd>Telescope current_buffer_fuzzy_find theme=get_ivy previewer=false<cr>
nnoremap qh <cmd>Telescope help_tags theme=get_ivy previewer=false<cr>
nnoremap qr <cmd>Telescope lsp_references theme=get_ivy<cr>
nnoremap qm <cmd>Telescope find_files theme=get_ivy previewer=false cwd='~/' <cr>
nnoremap <c-p> <cmd>lua require"telescope.builtin".find_files( { cwd = '~' } )<cr>
nnoremap Y y$
"inoremap . .<c-g>u "undo breakpoint
"nnoremap <BS> diw
inoremap <s-bs> <esc>diwi

vnoremap r :s/<c-r><c-w>/<left><left>

nmap <f7> :source ~/.config/nvim/nvim_nicke.vim<cr>
nmap <f8> :e ~/.config/nvim/nvim_nicke.vim<cr>
inoremap <c-f> (
inoremap <c-j> )
inoremap <c-g> [
inoremap <c-h> ]
inoremap <c-d> {
inoremap <c-k> }

onoremap <c-f> (
onoremap <c-j> )
onoremap <c-g> [
onoremap <c-h> ]
onoremap <c-d> {
onoremap <c-k> }

nmap <c-left> <cmd>vertical resize -3<CR>
nnoremap <silent> <C-Right> :vertical resize +3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

nnoremap J 10jzz
nnoremap K 10kzz
noremap H b
noremap L w

ca W w
ca Q q
ca Wq wq
ca WQ wq

"Telescope
hi TelescopeMatching guifg=lightgreen

"GRAY NORD THEME
 hi Normal guibg=none guifg=LightGray
 hi LineNr guifg=gray
 hi Comment guifg=gray
 hi SignColumn guibg=none
 hi cursorline guibg= gray22
 hi VertSplit guibg=gray22
"
"remove bgcolor for some themes
"hi Normal guibg=None
highlight LineNr ctermfg=darkgray
hi StatusLine ctermfg=darkgray
hi Statement ctermfg=14
hi Type ctermfg=13
highlight Pmenu ctermbg=darkgray ctermfg=white
highlight PmenuSel ctermbg=white ctermfg=black
highlight MatchParen ctermbg=darkgray ctermfg=white

"========= ALE SETTINGS ================
let g:ale_linters = {'cs': ['OmniSharp']}
let g:ale_sign_gutter_column_always = 1
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_sign_priority = 30
"hi clear ALEErrorSign
"hi clear ALEWarnSign

"========== GitGutter ==================
let g:git_gutter_sign_priority = 9

lua << EOF
require('lspsaga').init_lsp_saga {
	use_saga_diagnostic_sign = true,
	code_action_prompt = {
		enable = true,
		sign = true,
		sign_priority = 20,
		virtual_text = false,
	},
	code_action_keys = {
		quit = '<esc>',
		exec = '<cr>',
	},
}

require('telescope').setup{
defaults = {
	vimgrep_arguments = {
		'rg',
		'--color=never',
		'--no-heading',
		'--with-filename',
		'--line-number',
		'--column',
		'--smart-case',
		},
	color_devicons=true,
	theme=get_ivy
	},
extensions = {
	fzf = {
		fuzzy = true,
		override_generic_sorter = true,
		override_file_sorter = true,
		case_mode = 'smart_case',
		},
	},
}





require('telescope').load_extension('fzf')

require('nvim-treesitter').setup{}


require('lspconfig').serve_d.setup{on_attach=on_attach}


vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	virtual_text = false,
	signs = true,
}
)
------- Python --------
require('lspconfig').pyright.setup{on_attach=on_attach}

------- C# ----------
local pid = vim.fn.getpid()
local omnisharp_bin = ""
if vim.fn.has("mac") == 1 then
	omnisharp_bin = "/Users/nicke/.cache/omnisharp-vim/omnisharp-roslyn/run"
elseif vim.fn.has("win32") == 1 then --??
	omnisharp_bin = "c:/Users/nmk41/AppData/Local/omnisharp-vim/omnisharp-roslyn/OmniSharp.exe"
else 
	omnisharp_bin = "ERROR"
end
require('lspconfig').omnisharp.setup{ 
	cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
	filetypes = { "cs", "csx" },
	root_dir = function(fname) return "/Users/nicke" end, --this obviously needs fixing
}

------- lua ---------
local sumneko_root_path = vim.fn.getenv("HOME").."/Downloads/lua-language-server" -- Change to your sumneko root installation
--local sumneko_binary = sumneko_root_path .. '/extension/server/bin/macOS/lua-language-server'
local sumneko_binary = sumneko_root_path .. '/bin/macOS/lua-language-server'

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')

table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
	cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				filetypes = { "lua" },
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
--				library = vim.api.nvim_get_runtime_file('', true),
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	},
}
------- Compe setup -------------
require('compe').setup {
	enabled = true,
	autocomplete = true,
	debug = false,
	min_length = 1,
	preselect = 'disable',
	throttle_time = 80,
	source_timeout = 200,
	incomplete_delay = 400,
	max_abbr_width = 100,
	max_kind_width = 100,
	max_menu_width = 100,
	documentation = true,

	source = {
		path = true,
		nvim_lsp = true, -- { priority = 110, menu = "lsp" },
		nvim_lua = false, --{ priority = 200, menu = "lualsp" },
		calc = true,
		buffer = false,
		spell = false,
		tags = false,
		omni = false, --{ priority = 10, menu = "omni"},
		--treesitter = { priority = 200, menu ="tree" },
	},
}

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
	local col = vim.fn.col('.') - 1
	if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
		return true
	else
		return false
	end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
	if vim.fn.pumvisible() == 1 then
		return t "<C-n>"
	elseif check_back_space() then
		return t "<Tab>"
	else
		return vim.fn['compe#complete']()
	end
end
_G.s_tab_complete = function()
	if vim.fn.pumvisible() == 1 then
		return t "<C-p>"
	else
		return t "<S-Tab>"
	end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

EOF

lua << EOF
function test()
	local a = vim.lsp.buf_request(0, 'textDocument/completion', vim.lsp.util.make_position_params(), test_handler)
end

function test_handler(err, method, result, client_id, bufnr, config)
	print("test handleer")
	items = vim.lsp.util.text_document_completion_list_to_complete_items(result, "")
	print("err", vim.inspect(err))
	print("method", vim.inspect(method))
	print("result", vim.inspect(result))
	print("client_id", vim.inspect(client_id))
	print("bufnr", vim.inspect(bufnr))
	print("config", vim.inspect(config))
end

EOF
imap <c-space> <cmd> lua test()<cr>
nmap <c-ö> <cmd> lua test()<cr>
