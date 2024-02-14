-- Lua Plugin Config

require('lualine').setup()

require('toggleterm').setup({
    open_mapping = '<C-g>',
    direction = 'horizontal',
    shade_terminals = true,
    start_in_insert = true,
})

