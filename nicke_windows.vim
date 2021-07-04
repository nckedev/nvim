"Plugins
call plug#begin()
	Plug 'drewtempelmeyer/palenight.vim'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'arcticicestudio/nord-vim'

	"telescope needs fd and ripgrep for some features
	"install with scoop for windows
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'

	Plug 'easymotion/vim-easymotion'
	Plug 'phaazon/hop.nvim'

	"LSP
	Plug 'neovim/nvim-lspconfig'
	Plug 'hrsh7th/nvim-compe'

call plug#end()

set mouse=a
set hidden
set number
set hlsearch
set incsearch
set nobackup
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set ignorecase
set smartcase
set splitbelow splitright
set clipboard^=unnamed,unnamedplus
set completeopt=menuone,noselect

color nord
"let GuiPopupmenu 0

let g:EasyMotion_do_mapping = 0
"mappings
cab W w
cab Wq wq
cab WQ wq
let g:mapleader = " "
let mapleader = " "
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>ft <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <silent><f9> :Buffers<enter>
nnoremap <silent><f11> :bprev<cr>
nnoremap <silent><f12> :bnext<cr>
nnoremap <silent<silent>><f8> :source %<cr>:echo "sourced config"<cr>
map <C-f> <Plug>(easymotion-sn)

autocmd FileType python nnoremap <buffer> <silent><c-enter> :!python.exe %<cr>
autocmd FileType d set efm=%*[^@]@%f\(%l\):\ %m,%f\(%l\\,%c\):\ %m,%f\(%l\):\ %m
autocmd FileType d nnoremap <buffer> <silent><c-enter> :!rdmd %<cr>

autocmd BufWritePre * %s/\s\+$//e

"novim-qt opeing buffer bug fix
if @% == ""
				bd
endif

autocmd VimEnter * GuiPopupmenu 0

"fix lsp for
"d
"dart
"csharp
"luajit
"lua
"python
"vimscript
"rust
"
"

"LSP setup

lua << EOF
--npm i -g pyright
require'lspconfig'.pyright.setup{}

-- setup servers on attach (auto start)
local nvim_lsp = require('lspconfig')
local servers = { 'pyright' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

EOF

lua << EOF
-- Compe setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
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
