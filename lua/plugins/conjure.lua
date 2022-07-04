-- Let LSP do documentation and jump definitions
vim.cmd([[
  let g:conjure#mapping#doc_word = v:false
  let g:conjure#mapping#def_word= v:false
  let g:conjure#extract#tree_sitter#enabled = v:true
  let g:conjure#client#clojure#nrepl#test#raw_out = v:true
  let g:conjure#client#clojure#nrepl#eval#print_buffer_size = 8192
  let g:conjure#client#clojure#nrepl#test#runner = "kaocha"
  let g:conjure#client#clojure#nrepl#test#call_suffix = "{:kaocha/color? false :kaocha/reporter [kaocha.report/dots] :kaocha/plugins [:kaocha.plugin/capture-output] :config-file \"tests.edn\"}"
]])

vim.keymap.set("n", "<localleader>et", ":ConjureEvalRootForm<CR> <bar> :ConjureCljRunCurrentTest<CR>")
