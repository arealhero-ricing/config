call plug#begin()
" === Colorschemes ===

" Plug 'morhetz/gruvbox'
" Plug 'nanotech/jellybeans.vim'
Plug 'dylanaraps/wal.vim'

" ====================
Plug 'airblade/vim-gitgutter'
" === C++ Development ===
" LSP
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'

" Syntax highlighting
Plug 'jackguo380/vim-lsp-cxx-highlight'

" Debug Adapter Protocol
Plug 'puremourning/vimspector', {
	\ 'do': 'python3 install_gadget.py --enable-vscode-cpptools'
	\ }

" FZF
Plug 'junegunn/fzf'

Plug 'tpope/vim-commentary'

" =======================

call plug#end()

