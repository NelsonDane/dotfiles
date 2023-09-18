call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'github/copilot.vim'

Plug 'folke/tokyonight.nvim'

call plug#end()

colorscheme tokyonight-night

" Use Tab to accept suggestions
inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"

" Start NERDTree at start
autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
