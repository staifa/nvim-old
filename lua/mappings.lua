-- Luafile
vim.keymap.set('n', '<leader>lf', ':luafile %<CR>')

-- Shift + Enter crates new line
vim.keymap.set('n', '<S-Enter>', ' O<Esc>')

-- Buffer navigation
vim.keymap.set('n', 'gn', ':bn<cr>')
vim.keymap.set('n', 'gp', ':bp<cr>')
vim.keymap.set('n', 'gx', ':BD<cr>')
vim.keymap.set('n', 'gX', ':bd<cr>')

-- New tab
vim.keymap.set('n', '<C-n>', ':tabnew<CR>')

-- Hop bindings
-- vim.keymap.set('n', 'hh', ':HopWord<cr>')
-- vim.keymap.set('n', 'hl', ':HopLineStart<cr>')
-- vim.keymap.set('n', 'hp', ':HopPattern<cr>')

-- Sneak bindings
vim.keymap.set('n', 's', '<Plug>Sneak_s')
vim.keymap.set('n', 'S', '<Plug>Sneak_S')
vim.keymap.set('n', 'f', '<Plug>Sneak_f')
vim.keymap.set('n', 'F', '<Plug>Sneak_F')
vim.keymap.set('n', 't', '<Plug>Sneak_t')
vim.keymap.set('n', 'T', '<Plug>Sneak_T')

-- Space works in normal mode
vim.keymap.set('n', '<space>', ':s!^! !<CR>')
vim.keymap.set('n', '<Space>', 'i<Space><Esc>')

-- clear highlights
vim.keymap.set('n', '<Backspace>', ':noh<CR>')

-- close all buffers except current one
vim.keymap.set('n', '<leader>x', ':%bd|e#|bd#<CR>')
