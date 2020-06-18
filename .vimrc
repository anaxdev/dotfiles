filetype off
set nocompatible  " no vi compatibility.

set rtp+=~/.fzf
call plug#begin('~/.local/share/nvim/plugged')
" Plugins
Plug 'nathanaelkane/vim-indent-guides' " vim indent guides
Plug 'vim-airline/vim-airline' " airplanes go zoom
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline' " list buffers in command bar
Plug 'scrooloose/nerdtree' " file navigator
Plug 'altercation/vim-colors-solarized' " solarized colorscheme
Plug 'tmux-plugins/vim-tmux' "tmux.conf syntax highlighting
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' } "Go Development plugin
Plug 'vim-ruby/vim-ruby'
Plug 'jparise/vim-graphql'
Plug 'ekalinin/Dockerfile.vim' " Dockerfile syntax highlights
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'b4b4r07/vim-hcl'
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

filetype on
filetype plugin indent on

" Add recently accessed projects menu (project plugin)
set viminfo^=\!

" Airline Settings
"let g:airline_theme='luna'
let g:airline#extensions#branch#enabled = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_symbols.branch = '⎇'
let g:airline_theme="dark"

" Function Keys
set pastetoggle=<F2>
nnoremap <silent> <F5> :%s/\s\+$//<CR>
nnoremap <silent> <F6> :NERDTreeToggle<Return>
nnoremap <silent> <F7> :NERDTreeFind<Return>

syntax on
syntax enable
set cf  " Enable error files & error jumping.
set history=256  " Number of things to remember in history.
set autowrite  " Writes on make/shell commands
set ruler  " Ruler on
set nu  " Line numbers on
function! NumberToggle()
    if(&relativenumber ==1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunc
nmap <silent> <C-N><C-N> :set invnumber<CR>
nmap <silent> <C-M><C-M> :call NumberToggle()<CR>

set nohlsearch " disable highlight on search

set nowrap " Line wrapping off
set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay)
set showmode

" Formatting
set ts=2  " Tabs are 2 spaces
set bs=2  " Backspace over everything in insert mode
set shiftwidth=4  " Tabs under smart indent
set nocp incsearch
set cinoptions=:0,p0,t0
set formatoptions=tcqr
set cindent
set autoindent
set smarttab
set expandtab

" Visual
set encoding=utf-8
set showmatch  " Show matching brackets.
set mat=5  " Bracket blinking.
set lcs=tab:\ \ ,eol:$,trail:~,extends:>,precedes:<
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.
set background=dark
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
colorscheme solarized

" set vim indent guides plugin settings
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=DarkGrey
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=DarkGrey
let g:indent_guides_start_level = 2 " vim indent guides size
let g:indent_guides_guide_size = 1 " vim indent guides size
let g:indent_guides_enable_on_vim_startup = 1

" vim-go
let g:go_list_type = "quickfix"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_fmt_command = "goimports"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_build_tags='test integration'

" hcl plugin config
autocmd BufRead,BufNewFile *.hcl2 set expandtab shiftwidth=2 tabstop=2 filetype=hcl

" coc config - completion
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" <CR> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" auto format on completion
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
