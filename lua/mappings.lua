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

-- conjure
vim.keymap.set("n", "<localleader>cc", ":ConjureEval (dev.core/go)<CR>")
vim.keymap.set("n", "<localleader>cr", ":ConjureEval (dev.core/reset)<CR>")
vim.keymap.set("n", "<localleader>et", ":ConjureEvalRootForm<CR> <bar> :ConjureCljRunCurrentTest<CR>")

-- dir-telescope
vim.keymap.set("n", "<leader>j", "<cmd>Telescope dir live_grep<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>f", "<cmd>Telescope dir find_files<CR>", { noremap = true, silent = true })

-- fugitive, git
local git = require("plugins.fugitive")
vim.keymap.set("n", "<leader>gg", git.toggle_status, {})
vim.keymap.set("n", "<leader>gP", git.git_push, {})
vim.keymap.set("n", "<leader>gF", function() git.git_push({ force = 1 }) end, {})
vim.keymap.set('n', '<leader>gb', ':Gitsigns blame_line<CR>')
vim.keymap.set('n', '<leader>gr', ':Gitsigns reset_hunk<CR>')
vim.keymap.set('n', '<leader>gR', ':Gitsigns reset_buffer<CR>')
vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk<CR>')
vim.keymap.set('n', '<leader>gd', ':Gitsigns diffthis<CR>')
vim.keymap.set('n', '<leader>gw', ':Gwrite<CR>')
vim.keymap.set('n', '<leader>gC', ':G checkout ')
vim.keymap.set("n", "<leader>gs", ":G stash<CR>")
vim.keymap.set("n", "<leader>gS", ":G stash pop<CR>")

-- hop
vim.keymap.set('n', '<M-w>', '\\ew')
vim.keymap.set('n', '<M-f>', '\\ef')
vim.keymap.set('n', '<M-l>', '\\el')

local hop = require('hop')
vim.keymap.set('', '<M-w>', function()
  hop.hint_words()
end, { remap = true })
vim.keymap.set('', '<M-f>', function()
  hop.hint_patterns()
end, { remap = true })
vim.keymap.set('', '<M-l>', function()
  hop.hint_lines()
end, { remap = true })

-- tab navigation
vim.keymap.set("n", "<LocalLeader>gn", ":tabnext<CR>")
vim.keymap.set("n", "<LocalLeader>gp", ":tabprev<CR>")
vim.keymap.set("n", "<LocalLeader>gc", ":tabclose<CR> | :tabprev<CR>")

-- mundo
vim.keymap.set("n", "<localleader>u", ":MundoToggle<CR>")

-- neoscroll
local neoscroll_mappings = {}
neoscroll_mappings["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "200" } }
neoscroll_mappings["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "200" } }
require("neoscroll.config").set_mappings(neoscroll_mappings)

-- nevim tree
vim.keymap.set("n", "<F2>", ":NvimTreeToggle<CR>")
