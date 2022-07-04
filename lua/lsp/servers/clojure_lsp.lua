vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "conjure-log*",
  callback = function()
    -- disable diagnostics if they're on
    vim.diagnostic.disable()
  end,
  desc = "Turns off diagnostics for Conjure's buffer",
})

return {
  setup = function(on_attach, capabilities)
    require("lspconfig").clojure_lsp.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
}
