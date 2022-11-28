local toggle_status = function()
  local ft = vim.bo.filetype
  if ft == "fugitive" then
    vim.cmd("bd")
  else
    vim.cmd("Git")
  end
end

local git_push = function(opts)
  opts = opts or {}
  local head = vim.call("FugitiveHead")
  if opts.force then
    vim.fn.confirm("Force push to origin/" .. head .. " branch?")
    vim.cmd("G push origin " .. head .. " -f")
  else
    vim.fn.confirm("Push to origin/" .. head .. " branch?")
    vim.cmd("G push origin " .. head)
  end
end

local fcgroup = vim.api.nvim_create_augroup("FugitiveBufferCleanup", {})
vim.api.nvim_create_autocmd("BufUnload", {
  -- only on main fugitive window 
  pattern = "*fugitive://*/.git//",
  group = fcgroup,
  callback = function()
    local bufnr = vim.fn.bufnr()
    for _, buf in pairs(vim.fn.getbufinfo({bufloaded = 1})) do
      if buf.name:match(".*fugitive://.*") and buf.bufnr ~= bufnr then
        vim.cmd("bd " .. buf.bufnr)
      end
    end
  end,
  desc = "Close all fugitive buffers when closing the main fugitive window",
})

vim.keymap.set("n", "<leader>gg", toggle_status, {})
vim.keymap.set("n", "<leader>gP", git_push, {})
vim.keymap.set("n", "<leader>gF", function() git_push({force = 1}) end, {})
vim.keymap.set('n', '<leader>gb', ':Gitsigns blame_line<CR>')
vim.keymap.set('n', '<leader>gr', ':Gitsigns reset_hunk<CR>')
vim.keymap.set('n', '<leader>gw', ':Gwrite<CR>')
vim.keymap.set('n', '<leader>gC', ':G checkout ')
