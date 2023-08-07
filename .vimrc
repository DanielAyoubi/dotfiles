set clipboard=unnamedplus
set nocompatible
syntax on
set wrap
set wildmenu
set wildmode=longest:list,full
set mouse=n
set showmatch
set autoindent
set smartindent
set expandtab
set tabstop=4
set number
set smarttab
set shiftwidth=4
set hlsearch
set showcmd
set clipboard=unnamedplus
set wildignorecase

filetype indent on
filetype plugin indent on
set whichwrap+=<,>,[,]
let g:python3_host_prog = '/usr/bin/python3'


if has("title")
  set title
  set titlestring=%t
endif

:command WQ wq
:command Wq wq
:command W w
:command Q q

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lervag/vimtex'
" Plug 'Shougo/deoplete.nvim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'nordtheme/vim'
Plug 'luochen1990/rainbow'
Plug 'joshdick/onedark.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-commentary'
" Plug 'https://github.com/jiangmiao/auto-pairs'
Plug 'dense-analysis/ale'
" Plug 'Yggdroot/indentLine'
" Plug 'tpope/vim-fugitive'
Plug 'Raimondi/delimitMate'
" Plug 'editor-bootstrap/vim-bootstrap-updater'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/grep.vim'
" Plug 'tpope/vim-rhubarb' " required by fugitive to :Gbrowse
" Plug 'andymass/vim-matchup'

call plug#end()

let g:deoplete#enable_at_startup = 1
let g:vimtex_view_method = 'zathura'
let maplocalleader = ","


let g:rainbow_active = 1
let g:rainbow_conf = {
\  'guifgs': ['#FFD700', '#DA70D6', '#179FFF'],
\  'ctermbgs': ['75', '114', '204', '75', '114', '204'],
\  'guibgs': ['#FFD700', '#DA70D6', '#179FFF'],
\  'operators': '_,_',
\  'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\  'separately': {}
\}


"OmniSharp
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_highlighting = 0

if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif


map <c-n> :NERDTreeToggle<CR>

" colorscheme gruvbox
" colorscheme nord
colorscheme onedark
let g:airline_theme='onedark'
" let g:onedark_bg = 'ECEFF4'
" let g:airline_theme='nord_minimal'
" set background=dark

:tnoremap <Esc> <C-\><C-n>
:set guicursor=i-v:ver100
let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
inoremap <expr> <Tab> pumvisible() ? '<C-n>' :                                                                                                        
\ getline('.')[col('.')-2] =~# '[[:alnum:].-_#$]' ? '<C-x><C-o>' : '<Tab>'
nnoremap <C-o><C-u> :OmniSharpFindUsages<CR>
nnoremap <C-o><C-d> :OmniSharpGotoDefinition<CR>
nnoremap <C-o><C-d><C-p> :OmniSharpPreviewDefinition<CR>
nnoremap <C-o><C-r> :!dotnet run
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>
inoremap <C-BS> <C-W>
:highlight LineNr ctermfg=white
" imap <silent><expr> <C-Space> "\<c-y>"
inoremap <C-@> <C-y>
nnoremap d "_d
vnoremap d "_d
nnoremap x "_x
vnoremap x "_x
" nnoremap <C-j> :terminal<CR>:startinsert<CR>
nnoremap <C-R> :vsplit<CR>:wincmd l<CR>:terminal python %<CR>
nnoremap <C-W> :bd!<CR>
inoremap <expr> <CR> pumvisible() ? "\<C-y>\<C-r>=UltiSnips#ExpandSnippet()\<CR>" : "\<CR>"
map <C-a> <esc>ggVG<CR>

" Custom function to handle completion item insertion
function! CocCompleteSnippet()
  let completion_item = get(v:completed_item, 'user_data', '')
  if !empty(completion_item)
    let completion_item = json_decode(completion_item)
    if get(completion_item, 'isSnippet', 0)
      call feedkeys("\<C-r>=UltiSnips#Anon('".escape(completion_item['snippet'], "'")."')\<CR>", 'n')
    else
      call feedkeys("\<C-y>", 'n')
    endif
  endif
endfunction

" Modify the completeopt and completion key mapping
set completeopt=menuone,noinsert,noselect

" Use <C-y> to accept the completion item
inoremap <silent> <expr> <C-y> pumvisible() ? "\<ESC>:call CocCompleteSnippet()\<CR>a" : "\<C-y>"
