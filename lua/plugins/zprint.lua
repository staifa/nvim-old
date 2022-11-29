vim.g["zprint#make_autocmd"] = 0
vim.g.zprint_on = true
vim.api.nvim_create_user_command('SwitchZprint', function() vim.g.zprint_on = not vim.g.zprint_on end, {})

local zptgroup = vim.api.nvim_create_augroup("ZprintTweaks", {})
vim.api.nvim_create_autocmd("BufLeave", {
  pattern = {"*.clj", "*.cljs", "*.cljc"},
  group = zptgroup,
  callback = function()
    if not vim.g.zprint_on then return end
    local bufname = vim.api.nvim_buf_get_name(0)
    -- disable in conjure log
    if bufname:match(".*conjure%-log.*") then
      return
    end
    -- disable when working with fugitive
    for _, buf in pairs(vim.fn.getbufinfo({bufloaded = 1})) do
      if buf.name:match(".*fugitive://.*") then
        return
      end
    end
    vim.cmd("Zprint")
  end,
  desc = "Runs Zprint when leaving buffer",
})

local blgroup = vim.api.nvim_create_augroup("EOFBlankLines", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  group = blgroup,
  callback = function()
    vim.cmd([[v/\_s*\S/d]])
  end,
  desc = "Remove blank lines at EOF",
})
