call plug#begin()
	Plug 'airblade/vim-gitgutter'
	Plug 'tpope/vim-commentary'

	Plug 'OmniSharp/omnisharp-vim'
	Plug 'kabouzeid/nvim-lspinstall'
	Plug 'hrsh7th/nvim-compe'
	Plug 'neovim/nvim-lspconfig'
	Plug 'glepnir/lspsaga.nvim'
	Plug 'folke/trouble.nvim'
	Plug 'dense-analysis/ale'

	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'

	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}
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

lua << END
--lua saga.init_lsp_saga{ settings }
require('lspsaga').init_lsp_saga {
	use_saga_diagnostic_sign = true,
}
END

color nord
language en_US
syntax on
filetype plugin indent on
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


let g:EasyMotion_do_mapping = 0
let g:mapleader = "\<Space>"

if has('mouse')
	set mouse=a
endif
lua theme= require('telescope.themes').get_ivy { shorten_path=true }
nnoremap <leader>r <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <leader>K <cmd>lua vim.lsp.buf.hover()<cr>

nnoremap <leader>dl <cmd>Lspsaga show_line_diagnostics<cr>
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
nnoremap <leader>fb <cmd>Telescope buffers show_all_buffers=true theme=get_ivy<cr>
nnoremap <leader>ff <cmd>Telescope current_buffer_fuzzy_find theme=get_ivy previewer=false<cr>
nnoremap <leader>fF <cmd>Telescope find_files<cr>
nnoremap <leader>fB <cmd>Telescope file_browser<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>4 :w<cr>:!rdmd %<cr>
nnoremap <leader>5 :w<cr>:!rdmd -unittest %<cr>
map <C-f> <Plug>(easymotion-sn)
lua << EOF
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
	-- Enable underline, use default values
	underline = true,
	-- Enable virtual text, override spacing to 4
	virtual_text = false,
	signs = true,
	-- Use a function to dynamically turn signs off
	-- and on, using buffer local variables
	}
)
EOF

nnoremap Q q
nnoremap q <cmd>Telescope<cr>

nmap <f7> :source ~/.config/nvim/init.vim<cr>
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

nnoremap J 10j
nnoremap K 10k
noremap H b
noremap L w

ca W w
ca Q q
ca Wq wq
ca WQ wq
ca WQ wq

"Telescope
hi TelescopeMatching guifg=lightblue

"GRAY NORD THEME
" hi Normal guibg=none
" hi LineNr guifg=gray
" hi Comment guifg=gray
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

lua require('telescope').setup{ color_devicons=true }


lua require('lspconfig').serve_d.setup{on_attach=on_attach}
lua << EOF
--require'lspconfig'.dls.setup{}
EOF

lua << EOF
--npm i -g pyright
require('lspconfig').pyright.setup{on_attach=on_attach}
--local nvim_lsp = require('lspconfig')
--local servers = { 'pyright' }
--for _, lsp in ipairs(servers) do
--  nvim_lsp[lsp].setup { on_attach = on_attach }
--end
EOF
lua << EOF
local pid = vim.fn.getpid()

local omnisharp_bin = ""
if vim.fn.has("mac") == 1 then
	 omnisharp_bin = "/Users/nicke/.cache/omnisharp-vim/omnisharp-roslyn/run"
elseif vim.fn.has("win32") == 1 then --??
	 omnisharp_bin = "c:/Users/nmk41/AppData/Local/omnisharp-vim/omnisharp-roslyn/OmniSharp.exe"
else 
	omnisharp_bin = "ERROR"
end
require('lspconfig').omnisharp.setup{ cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) }; }
EOF

"========= ALE SETTINGS ================
let g:ale_linters = {'cs': ['OmniSharp']}
let g:ale_sign_gutter_column_always = 1
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
"hi clear ALEErrorSign
"hi clear ALEWarnSign

lua << EOF
local sumneko_root_path = vim.fn.getenv("HOME").."/.local/share/nvim/lspinstall/lua" -- Change to your sumneko root installation
--local sumneko_binary = sumneko_root_path .. '/extension/server/bin/macOS/lua-language-server'
local sumneko_binary = sumneko_root_path .. '/sumneko-lua-language-server'

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
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
EOF
lua << EOF
-- Compe setup
require('compe').setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  --preselect = 'enable';
  preselect = 'disable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
	calc = true;
  };
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

