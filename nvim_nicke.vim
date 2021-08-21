call plug#begin()
	Plug 'nckedev/ctrlf' 
	Plug 'dart-lang/dart-vim-plugin'
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
	
	"themes
	Plug 'arcticicestudio/nord-vim'
	Plug 'nanotech/jellybeans.vim'
	Plug 'morhetz/gruvbox'
	Plug 'chriskempson/base16-vim'

	Plug 'sunjon/shade.nvim'

	"Plug 'easymotion/vim-easymotion'
	"Plug 'ggandor/lightspeed.nvim'
	"Plug 'phaazon/hop.nvim'

	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
call plug#end()

color nord
language message en_US
language ctype sv_SE
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

set completeopt=menuone,noinsert,noselect

"for neovide{
if exists('g:neovide')
	set guifont=SauceCodePro\ NF:h15
	let g:neovide_iso_layout = v:true
	let g:neovide_cursor_vfx_mode = "railgun"
	let g:neovide_input_use_logo= v:true

endif
autocmd BufRead,BufNewFile *.csx set filetype=cs


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

autocmd FileType python nmap <f5> :!python %<cr>

map s <cmd>Ctrlf<cr>
map ä <cmd>Ctrlf<cr>
nnoremap <c-f> <cmd>Ctrlf<cr>
noremap <leader>j <cmd>Ctrlf<cr>
noremap <c-space> <cmd>CtrlfNext<cr>

nnoremap <leader>y "*y
nnoremap <leader>Y "*Y
nnoremap <leader>p "*p
nnoremap <leader>P "*P
nnoremap <c-l> <cmd>wincmd w<cr>
nnoremap <c-h> <cmd>wincmd W<cr>

nnoremap Q q
nnoremap q <cmd>Telescope builtin theme=get_ivy previewer=false <cr>

if has('mac')
	nmap <f7> :source ~/.config/nvim/init.vim<cr>
endif
if has('win64')
	nmap <f7> :source C:\Users\nmk41\AppData\Local\nvim\init.vim<cr>
endif

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

nmap <c-left> <cmd>vertical resize +3<CR>
nnoremap <silent> <C-Right> :vertical resize -3<CR>
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
if has('mac')
 hi Normal guibg=none guifg=LightGray
 hi LineNr guifg=gray
 hi Comment guifg=gray
 hi SignColumn guibg=none
 hi cursorline guibg= gray22
 hi VertSplit guibg=gray22
 endif
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
let g:ale_linters = {'cs': ['OmniSharp'], 'py' : ['pylint']}
let g:ale_sign_gutter_column_always = 1
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_sign_priority = 30
let g:ale_python_pylint_options='disable=missing-function-docstring'
"hi clear ALEErrorSign
"hi clear ALEWarnSign

"========== GitGutter ==================
let g:git_gutter_sign_priority = 9


luafile ~/.config/nvim/compe_config.lua
luafile ~/.config/nvim/omnisharp.lua
luafile ~/.config/nvim/debugger.lua

lua << EOF

require('shade').setup({
	overlay_opacity = 50,
	opacity_step = 1,
})

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
--require('telescope').load_extension('fzf')

require('nvim-treesitter').setup{}

local dart_dir = ""
if vim.fn.has('win32') == 1 then
	dart_dir = "C:\\Users\\nmk41\\scoop\\apps\\dart\\current\\bin\\dart.exe"
elseif vim.fn.has('mac') == 1 then
	dart_dir = ""
end


require('lspconfig').dartls.setup{}
--require('lspconfig').dartls.setup{ cmd = { 'dart', 'C:\\Users\\nmk41\\scoop\\apps\\dart\\current\\bin\\snapshots\\analysis_server.dart.snapshot', '--lsp' } }

--	root_dir = "C:\\Users\\nmk41",
--}

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
EOF

lua << EOF
function test()
	local a = vim.lsp.buf_request(0, 'textDocument/completion', vim.lsp.util.make_position_params(), test_handler)
end

function test_handler(err, method, result, client_id, bufnr, config)
	print("test handleer")
	items = vim.lsp.util.text_document_completion_list_to_complete_items(result, "")
--	vim.lsp.util.extract_completion_items(result)
	print("items", vim.inspect(items))
	--print("err", vim.inspect(err))
	-- print("method", vim.inspect(method))
	-- print("result", vim.inspect(result))
	-- print("client_id", vim.inspect(client_id))
	--print("bufnr", vim.inspect(bufnr))
	-- print("config", vim.inspect(config))
end

EOF
imap <c-space> <cmd> lua test()<cr>
