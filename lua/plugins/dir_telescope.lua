require("dir-telescope").setup({
  hidden = true,
  respect_gitignore = true,
})

vim.keymap.set("n", "<leader>j", "<cmd>Telescope dir live_grep<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>f", "<cmd>Telescope dir find_files<CR>", { noremap = true, silent = true })
