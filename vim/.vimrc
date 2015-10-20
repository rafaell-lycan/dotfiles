"" Remove compatibility with legacy vi
set nocompatible
filetype off

"" Load plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"" Plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'pangloss/vim-javascript'
Plugin 'airblade/vim-gitgutter'
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-markdown'
Plugin 'tomasr/molokai'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'tpope/vim-surround'
Plugin 'bling/vim-airline'

call vundle#end()

filetype plugin indent on 

"" Encoding anyone?
set encoding=utf-8
set termencoding=utf-8

"" Basic Setup
set showcmd
set autoindent
set laststatus=2
set cmdheight=2
set smartindent

set linespace=3 
set linebreak
set textwidth=80

set ruler
set list
set showmatch
set foldenable
set ffs=unix,mac,dos 
set autoread

set cursorline

set listchars=tab:▸\ ,eol:¬,trail:⋅,nbsp:␣,extends:❯,precedes:❮

"" Numbers
set number
set numberwidth=5


"" Whitespace
set wrap
set backspace=indent,eol,start
set list
set term=screen-256color
set tabstop=2
set shiftwidth=2 
set softtabstop=2
set shiftround
set expandtab

"" Searching
set hlsearch  
set incsearch 
set ignorecase
set smartcase

"" Tab completion
"" will insert tab at beginning of line,
"" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

"" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

"" Color Scheme
let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai

set wildmenu
""set wildmode=full
set wildmode=list:longest,list:full

"" Enable fancy mode 
let g:Powerline_symbols = 'fancy'   "" Powerline

"" Switch syntax highlighting on, when the terminal has colors
"" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

"" NERDTreeTabs Toggle
map <C-n> :NERDTreeToggle<CR>

