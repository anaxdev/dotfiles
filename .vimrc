filetype off
set nocompatible  " no vi compatibility.

set rtp+=/usr/local/opt/fzf
call plug#begin('~/.local/share/nvim/plugged')
" Plugins
Plug 'nathanaelkane/vim-indent-guides' " vim indent guides
Plug 'scrooloose/syntastic' " syntax checker
Plug 'vim-airline/vim-airline' " airplanes go zoom
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive' " git wrapper
Plug 'bling/vim-bufferline' " list buffers in command bar
Plug 'tpope/vim-surround' " surroundings
Plug 'AndrewRadev/splitjoin.vim' " splitjoin
Plug 'scrooloose/nerdtree' " file navigator
Plug 'altercation/vim-colors-solarized' " solarized colorscheme
Plug 'tpope/vim-commentary' " commenting
Plug 'vim-scripts/java_getset.vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'tmux-plugins/vim-tmux' "tmux.conf syntax highlighting
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' } "Go Development plugin
Plug 'vim-ruby/vim-ruby'
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py' } "Autocomplete
"Plug 'ctrlpvim/ctrlp' "fuzzy finder
Plug 'ekalinin/Dockerfile.vim' " Dockerfile syntax highlights
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()

filetype on
filetype plugin indent on

" Add recently accessed projects menu (project plugin)
set viminfo^=\!

" Minibuffer Explorer Settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" Airline Settings
"let g:airline_theme='luna'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_symbols.branch = '⎇'
let g:airline_theme="dark"

" Syntastic
autocmd VimEnter * SyntasticToggleMode

" Function Keys
set pastetoggle=<F2>
nnoremap <F3> :SyntasticCheck<Return>
nnoremap <F10> :SyntasticToggleMode<Return>
nnoremap <silent> <C-T> :NERDTree<Return>
nnoremap <F4> gcc
nnoremap <silent> <F5> :%s/\s\+$//<CR>

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

set nohlsearch

set nowrap " Line wrapping off
set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay)
set showmode

" Formatting
set ts=4  " Tabs are 4 spaces
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
"let g:solarized_termcolors = 256
"let g:solarized_termtrans = 1
colorscheme solarized
"colorscheme desert-warm-256

" set vim indent guides plugin settings
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=DarkGrey
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=DarkGrey
let g:indent_guides_start_level = 2 " vim indent guides size
let g:indent_guides_guide_size = 1 " vim indent guides size
let g:indent_guides_enable_on_vim_startup = 1

" vim-go and syntastic lag fix
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_list_type = "quickfix"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
"autocmd FileType go nmap <leader>b :GoBuild<CR>
"autocmd FileType go nmap <leader>r :GoRun<CR>
