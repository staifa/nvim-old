local u = require("functions.utils")

local toggle_status = function()
  local ft = vim.bo.filetype
  if ft == "fugitive" then
    vim.api.nvim_command("bd")
  else
    vim.api.nvim_command("Git")
  end
end

local git_push = function()
  local isSubmodule = vim.fn.trim(vim.fn.system("git rev-parse --show-superproject-working-tree"))
  if isSubmodule == "" then
    if u.get_os() == "Linux" then
      vim.api.nvim_command("Git push")
    else
      vim.api.nvim_command("! git push")
    end
  else
    vim.fn.confirm("Push to origin/main branch for submodule?")
    vim.api.nvim_command("! git push origin HEAD:main")
  end
end

local git_open = function()
  vim.api.nvim_command("! git open")
end

local git_mr_open = function()
  if u.get_os() == "Linux" then
    os.execute(
      string.format(
        "firefox --new-tab 'https://gitlab.com/crossbeam/%s/-/merge_requests?scope=all&state=opened&author_username=frantisek.stainer'",
        u.current_dir()
      )
    )
  end
end

local fgroup = vim.api.nvim_create_augroup("FugitiveBufferCleanup", {})
vim.api.nvim_create_autocmd("BufUnload", {
  pattern = "*fugitive://*/.git//",
  group = fgroup,
  callback = function()
    local current_bufname = vim.api.nvim_buf_get_name(0)
    for _, buf in pairs(vim.fn.getbufinfo({bufloaded = 1})) do
      if buf.name:match(".*fugitive://.*") and buf.name ~= current_bufname then
        vim.api.nvim_input(":bd " .. buf.name .. "<CR>")
      end
    end
  end,
  desc = "Close all fugitive buffers when closing the main buffer",
})

vim.keymap.set("n", "<localleader>gs", toggle_status, {})
vim.keymap.set("n", "<leader>gP", git_push, {})
vim.keymap.set("n", "<leader>goo", git_open, {})
vim.keymap.set("n", "<leader>gom", git_mr_open, {})
vim.keymap.set('n', '<localleader>gw', ':Gwrite<CR>')
vim.keymap.set('n', '<localleader>ge', ':Gedit<CR>')
vim.keymap.set('n', '<localleader>gc', ':Git commit<CR>')
vim.keymap.set('n', '<localleader>gC', ':Git checkout')
