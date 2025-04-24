" ~/.config/nvim/init.vim

" vim-plug setup
call plug#begin(stdpath('data') . '/plugged')

Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'ervandew/supertab'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'PhilRunninger/nerdtree-buffer-ops'

call plug#end()

" Basic options
set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax on
set number

" Tabs & indentation
set shiftwidth=4
set expandtab
set tabstop=8
set softtabstop=0
set smarttab

" Optional: make <leader> useful
let mapleader = " "