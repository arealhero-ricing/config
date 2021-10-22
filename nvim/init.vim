source $HOME/.config/nvim/plugins.vim

set number relativenumber
set hlsearch
" set cc=80
set scrolloff=5

set updatetime=100

filetype plugin indent on
syntax on

let mapleader = ","

" FZF

nnoremap <leader>f :FZF<CR>

" Colorscheme

set background=dark
autocmd VimEnter * hi Normal ctermbg=none

colorscheme wal
" let g:gruvbox_contrast_dark = 'hard'
" colorscheme gruvbox

function! s:ColorPicker()
	call fzf#run({'source': map(split(globpath(&rtp, 'colors/*.vim')),
            \               'fnamemodify(v:val, ":t:r")'),
            \ 'sink': 'colo'})
endfunction

" C++ documentation in form of man pages
function! s:CppMan()
	let old_isk = &iskeyword
	setl iskeyword+=:
	let str = expand("<cword>")
	let &l:iskeyword = old_isk
	execute 'Man ' . str
endfunction
command! CppMan :call s:CppMan()

au Filetype cpp nnoremap <buffer>K :CppMan<CR>

" Omni-completion
if executable('ccls')
	autocmd User lsp_setup call lsp#register_server({
		\ 'name': 'ccls',
		\ 'cmd': { server_info->['ccls'] },
		\ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json')) },
		\ 'initialization_options': {
		\	'highlight': { 'lsRanges': v:true },
		\ },
		\ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc', 'h', 'hpp'],
		\ })
	autocmd FileType c setlocal omnifunc=lsp#complete
	autocmd FileType cpp setlocal omnifunc=lsp#complete
	autocmd FileType objc setlocal omnifunc=lsp#complete
	autocmd FileType objcpp setlocal omnifunc=lsp#complete
endif

" DAP
command! -nargs=+ Vfb call vimspector#AddFunctionBreakpoint(<f-args>)
nnoremap <leader>gd :call vimspector#Launch()<CR>
nnoremap <leader>gc :call vimspector#Continue()<CR>
nnoremap <leader>gs :call vimspector#Stop()<CR>
nnoremap <leader>gR :call vimspector#Restart()<CR>
nnoremap <leader>gp :call vimspector#Pause()<CR>
nnoremap <leader>gb :call vimspector#ToggleBreakpoint()<CR>
nnoremap <leader>gB :call vimspector#ToggleConditionalBreakpoint()<CR>
nnoremap <leader>gn :call vimspector#StepOver()<CR>
nnoremap <leader>gi :call vimspector#StepInto()<CR>
nnoremap <leader>go :call vimspector#StepOut()<CR>
nnoremap <leader>gr :call vimspector#RunToCursor()<CR>

