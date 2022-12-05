-- Let LSP do documentation and jump definitions
vim.g["conjure#mapping#doc_word"] = false
vim.g["conjure#mapping#def_word"] = false
vim.g["conjure#extract#tree_sitter#enabled"] = true
vim.g["conjure#client#clojure#nrepl#test#raw_out"] = true
vim.g["conjure#client#clojure#nrepl#eval#print_buffer_size"] = 8192
-- vim.g["conjure#client#clojure#nrepl#test#runner"] = "kaocha"
-- vim.g["conjure#client#clojure#nrepl#test#call_suffix"] = "{:kaocha/color? false :kaocha/reporter [kaocha.report/dots] :config-file \"tests.edn\"}"
