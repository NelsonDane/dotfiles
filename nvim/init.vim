" Install vim-plug automatically
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree',

Plug 'nvim-lua/plenary.nvim',
Plug 'nvim-telescope/telescope.nvim',

Plug 'lukas-reineke/indent-blankline.nvim',

Plug 'nvim-lualine/lualine.nvim',
Plug 'nvim-tree/nvim-web-devicons',

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'github/copilot.vim',

Plug 'folke/tokyonight.nvim',

call plug#end()

" Set colorscheme
colorscheme tokyonight-night

" Use Tab to accept suggestions
inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"

" Start NERDTree at start
autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
