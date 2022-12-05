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

return {
  toggle_status = function()
    local ft = vim.bo.filetype
    if ft == "fugitive" then
      vim.cmd("bd")
    else
      vim.cmd("Git")
    end
  end,
  git_push = function(opts)
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
}
