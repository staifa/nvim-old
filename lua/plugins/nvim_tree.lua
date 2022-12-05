local function on_attach(bufnr)
	local api = require('nvim-tree.api')

	local function opts(desc)
		return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
	vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
	vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
	vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
	vim.keymap.set('n', '<Enter>', api.node.open.edit, opts('Open'))
	vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
	vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
	vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
	vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
	vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
	vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
	vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
	vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
	vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
	vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
	vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
	vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
	vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
	vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
	vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
	vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
	vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
	vim.keymap.set('n', 'E', api.tree.toggle_help, opts('Expand All'))
end

require("nvim-tree").setup({
	on_attach = on_attach,
	renderer = {
		icons = {
			glyphs = {
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				},
				folder = {
					arrow_open = "",
					arrow_closed = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
			},
		},
	},
	disable_netrw = true,
	hijack_netrw = true,
	open_on_tab = false,
	hijack_cursor = false,
	update_cwd = false,
	git = {
		enable = true,
		ignore = false,
	},
	diagnostics = {
		enable = true,
		icons = { hint = "", info = "", warning = "", error = " " },
	},
	update_focused_file = {
		enable = true,
		update_cwd = false,
		ignore_list = {},
	},
	filters = { dotfiles = false, custom = {} },
	view = {
		width = 40,
		hide_root_folder = false,
		side = "left",
		mappings = {
			custom_only = true,
		},
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
})
