-- Luafile
vim.keymap.set('n', '<leader>lf', ':luafile %<CR>')

-- Buffer navigation
vim.keymap.set('n', 'gn', ':bn<CR>')
vim.keymap.set('n', 'gp', ':bp<CR>')
vim.keymap.set('n', 'gx', ':BD<CR>')
vim.keymap.set('n', 'gX', ':bd<CR>')

-- New tab
vim.keymap.set('n', '<C-n>', ':tabnew<CR>')

-- Sneak bindings
vim.keymap.set('n', 's', '<Plug>Sneak_s')
vim.keymap.set('n', 'S', '<Plug>Sneak_S')
vim.keymap.set('n', 'f', '<Plug>Sneak_f')
vim.keymap.set('n', 'F', '<Plug>Sneak_F')
vim.keymap.set('n', 't', '<Plug>Sneak_t')
vim.keymap.set('n', 'T', '<Plug>Sneak_T')

-- Space works in normal mode
vim.keymap.set('n', '<Space>', 'i<Space><Esc>')

-- clear highlights
vim.keymap.set('n', '<Backspace>', ':noh<CR>')

-- close all buffers except current one
vim.keymap.set('n', '<leader>x', ':%bd|e#|bd#<CR>')
