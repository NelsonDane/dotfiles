" Install vim-plug automatically
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Sidebar
Plug 'preservim/nerdtree'

" Autocomplete
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'gelguy/wilder.nvim'

" Git
Plug 'kdheepak/lazygit.nvim'

" Statusline
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'

" Syntax
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fannheyward/coc-pyright', {'do': 'yarn install --frozen-lockfile'}
Plug 'github/copilot.vim'

" Terminal
Plug 'akinsho/toggleterm.nvim', {'tag': '*'}

" Colorscheme
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'daltonmenezes/aura-theme', { 'rtp': 'packages/neovim' }

call plug#end()

" Set colorscheme
colorscheme aura-dark

" Set autocomplete
call wilder#setup({'modes': [':', '/', '?']})
call wilder#set_option('renderer', wilder#popupmenu_renderer({
      \ 'highlighter': wilder#basic_highlighter(),
      \ 'pumblend': 20,
      \ }))
call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
      \ 'highlighter': wilder#basic_highlighter(),
      \ 'highlights': {
      \   'border': 'Normal',
      \ },
      \ 'border': 'rounded',
      \ })))

" Use Tab to accept suggestions
inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"

" Set line numbers
set number
set relativenumber
set showtabline=2

" Tabs
map <C-t> :tabnew<CR>
map <C-w> :tabclose<CR>
map <C-n> :tabprevious<CR>
map <C-m> :tabnext<CR>

" Save as sudo
cnoremap w!! SudaWrite

" Lazygit
cnoremap lg :LazyGit<CR>

" Move through windows
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

" NERDTree
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Toggle NERDTree with ctrl+/ 
noremap <C-/> :NERDTreeToggle<CR>
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Terminal
tnoremap <Esc> <C-\><C-n>
" Open toggle term with Shift+T
nnoremap <S-t> :lua require('toggleterm').toggle()<CR>

" Source Lua
lua require('plugins')
