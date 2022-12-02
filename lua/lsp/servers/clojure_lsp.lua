return {
  setup = function(on_attach, capabilities)
    require("lspconfig").clojure_lsp.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      -- cmd = { "/home/staifa/clj-stuff/clojure-lsp/clojure-lsp" },
    })
  end,
}
