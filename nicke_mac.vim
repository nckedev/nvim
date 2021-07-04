call plug#begin()
	Plug 'OmniSharp/omnisharp-vim'
	Plug 'kabouzeid/nvim-lspinstall'
	Plug 'neovim/nvim-lspconfig'
	Plug 'nvim-lua/completion-nvim'

	Plug 'dense-analysis/ale'

	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'

	Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}
	Plug 'arcticicestudio/nord-vim'
call plug#end()

lua require'lspconfig'.pyright.setup{on_attach=require'completion'.on_attach}

lua local pid = vim.fn.getpid()
if has("mac")
	lua local omnisharp_bin = "/Users/nicke/.cache/omnisharp-vim/omnisharp-roslyn/run"
elseif has("win32")
	lua local omnisharp_bin = ""
endif
lua require'lspconfig'.omnisharp.setup{ cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) }; }

color nord
syntax on
filetype plugin indent on
set number 
set hlsearch
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

let g:mapleader = "\<Space>"

if has('mouse')
	set mouse=a
endif

nnoremap <leader>fb <cmd>Telescope buffers show_all_buffers=true<cr>
nnoremap <leader>ff <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fF <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>4 :w<cr>:!rdmd %<cr>
nnoremap <leader>5 :w<cr>:!rdmd -unittest %<cr>

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

highlight LineNr ctermfg=darkgray
hi StatusLine ctermfg=darkgray
hi Statement ctermfg=14
hi Type ctermfg=13
highlight Pmenu ctermbg=darkgray ctermfg=white
highlight PmenuSel ctermbg=white ctermfg=black
highlight MatchParen ctermbg=darkgray ctermfg=white



