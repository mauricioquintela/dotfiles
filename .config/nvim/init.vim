let mapleader =" "

call plug#begin('~/.vim/plugged')
Plug 'junegunn/goyo.vim'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'LukeSmithxyz/vimling'
Plug 'vimwiki/vimwiki'
Plug 'terryma/vim-multiple-cursors'
Plug 'mcchrish/nnn.vim'
Plug 'vifm/vifm.vim'
cal plug#end()


execute pathogen#infect()
" Some basics:
set nocompatible
filetype plugin on
syntax enable
set encoding=utf-8
set number
set relativenumber
set modeline	
:colorscheme default
set background=dark
" Enable autocompletion:
set wildmode=longest,list,full
" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" NnnPicker stuff
map <leader>n :NnnPicker<CR>
" Or pass a dictionary with window size
let g:nnn#layout = { 'left': '~20%' } " or right, up, down


" Goyo plugin makes text more readable when writing prose:
map <leader>f :Goyo \| set linebreak <CR> 

" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_us<CR>

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow
set splitright

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Check file in shellcheck:
map <leader>s :!clear && shellcheck %<CR>
" Open the selected text in a split (i.e. should be a file).
map <leader>o "oyaW:sp <C-R>o<CR>
xnoremap <leader>o "oy<esc>:sp <C-R>o<CR>
vnoremap <leader>o "oy<esc>:sp <C-R>o<CR>

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Open corresponding .pdf
map <leader>p :!opout <c-r>%<CR><CR>

" Compile document
map <leader>c :!compiler <c-r>%<CR>

"For saving view folds:
"au BufWinLeave * mkview
"au BufWinEnter * silent loadview

" Interpret .md files, etc. as .markdown
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

" Make calcurse notes markdown compatible:
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
" Readmes autowrap text:
autocmd BufRead,BufNewFile *.md set tw=79

" Get line, word and character counts with F3:
map <F3> :!wc %<CR>

" Spell-check set to F6:
map <F6> :setlocal spell! spelllang=en_us<CR>

" Use urlview to choose and open a url:
:noremap <leader>u :w<Home>silent <End> !urlscan<CR>
:noremap ,, :w<Home>silent <End> !urlscan<CR>

" Copy selected text to system clipboard (requires gvim installed):
vnoremap <C-c> "*Y :let @+=@*<CR>
map <C-p> "+P

function! s:goyo_leave()
	:colorscheme default
	set background=dark
"	:hi Normal ctermbg=black guibg=black
endfunction
autocmd! User GoyoLeave nested call <SID>goyo_leave()
set termguicolors
highlight Normal ctermbg=Black
highlight NonText ctermbg=Black
"highlight Normal ctermbg=black guibg=black



" Vifm 
map <Leader>vv :Vifm<CR>
map <Leader>vs :VsplitVifm<CR>
map <Leader>sp :SplitVifm<CR>
map <Leader>dv :DiffVifm<CR>
map <Leader>tv :TabVifm<CR>

set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2
