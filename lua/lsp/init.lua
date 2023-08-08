require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")
local lsp_format = require("lsp-format")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

lsp_format.setup({
	order = {
		"tsserver",
		"eslint",
	}
})

-- Map keys after LSP attaches (utility function)
local on_attach = function(client, bufnr)
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Debounce by 300ms by default
	client.config.flags.debounce_text_changes = 300

	-- This will set up formatting for the attached LSPs
	client.server_capabilities.documentFormattingProvider = true

	-- Formatting for Vue handled by Eslint
	-- Formatting for Clojure handled by custom ZPrint function, see lua/lsp/servers/clojure-lsp.lua
	if (client.name ~= "volar"
			and client.name ~= "tsserver"
			-- and client.name ~= "clojure_lsp"
			-- and client.name ~= "groovyls"
			and client.name ~= "lua_ls") then
		lsp_format.on_attach(client)
	end

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
	vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
	vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, {})
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help)
	vim.keymap.set("n", "<C-a>", vim.lsp.buf.code_action)
	vim.keymap.set("n", "<localleader>r", vim.lsp.buf.rename, {})
	vim.keymap.set("n", "<leader>]", function()
		vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
	end)
	vim.keymap.set("n", "<leader>[", function()
		vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
	end)

	vim.keymap.set("n", "<leader>w", function()
		vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARNING })
	end)

	vim.keymap.set("n", "<leader>W", function()
		vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARNING })
	end)

	-- This is ripped off from https://github.com/kabouzeid/dotfiles, it's for tailwind preview support
	if client.server_capabilities.colorProvider then
		require("lsp/colorizer").buf_attach(bufnr, { single_column = false, debounce = 500 })
	end
end

local normal_capabilities = vim.lsp.protocol.make_client_capabilities()

-- cmp_nvim_lsp.update_capabilities is deprecated, use cmp_nvim_lsp.default_capabilities
local capabilities = cmp_nvim_lsp.default_capabilities(normal_capabilities)

-- These servers are automatically installed by Mason.
-- We then iterate over their names and load their relevant
-- configuration files, which are stored in lua/lsp/servers,
-- passing along the global on_attach and capabilities functions
local servers = {
	"lua_ls",
	"clojure_lsp",
	-- "tailwindcss",
	-- "tsserver",
	-- "eslint",
	-- "volar",
	-- "groovyls",
}

-- Setup Mason + LSPs + CMP
require("lsp.cmp")
mason_lspconfig.setup({ ensure_installed = servers, automatic_installation = true })

-- Setup each server
for _, s in pairs(servers) do
	local server_config_ok, mod = pcall(require, "lsp.servers." .. s)
	if not server_config_ok then
		print("The LSP '" .. s .. "' does not have a config.")
	else
		mod.setup(on_attach, capabilities)
	end
end

-- Global diagnostic settings
vim.diagnostic.config({
	virtual_text = true,
	severity_sort = true,
	update_in_insert = false,
	float = {
		header = "",
		source = "always",
		border = "solid",
		focusable = true,
	},
})

-- Removing errors from gutter for now, trying inline errors instead

-- Change Error Signs in Gutter
-- local signs = { Error = "✘", Warn = " ", Hint = "", Info = " " }
local signs = { Error = "", Warn = "", Hint = "", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon })
	-- vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "solid",
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
	vim.lsp.handlers.signature_help, {
		border = "solid",
	})
