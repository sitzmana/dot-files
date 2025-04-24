call plug#begin()
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
"Plug 'dmerejkowsky/vim-ale'
Plug 'tpope/vim-surround'
Plug 'ervandew/supertab'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'PhilRunninger/nerdtree-buffer-ops'


call plug#end()
set number
set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax on

set shiftwidth=4 smarttab
set expandtab
set tabstop=8 softtabstop=0
