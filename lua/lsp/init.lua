local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local lsp_installer_status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")

if not (cmp_nvim_lsp_status_ok and lsp_installer_status_ok) then
	print("LSPConfig, CMP_LSP, and/or LSPInstaller not installed!")
	return
end

-- Configure CMP
require("lsp.cmp")

-- Map keys after LSP attaches (utility function)
local on_attach = function(client, bufnr)
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Debounce by 300ms by default
	client.config.flags.debounce_text_changes = 300
	client.server_capabilities.documentFormattingProvider = false

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
	vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
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

	-- This is ripped off from https://github.com/kabouzeid/dotfiles, it's for tailwind preview support
	if client.server_capabilities.colorProvider then
		require("lsp/colorizer").buf_attach(bufnr, { single_column = false, debounce = 500 })
	end
end

local normal_capabilities = vim.lsp.protocol.make_client_capabilities()

-- From nvim-ufo
normal_capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

local capabilities = cmp_nvim_lsp.default_capabilities(normal_capabilities)

lsp_installer.on_server_ready(function(server)
	local server_status_ok, server_config = pcall(require, "lsp.servers." .. server.name)
	if not server_status_ok then
		print("The LSP '" .. server.name .. "' does not have a config.")
		server:setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	else
		server_config.setup(on_attach, capabilities, server)
	end
end)

-- Global diagnostic settings
vim.diagnostic.config({
	virtual_text = false,
	severity_sort = true,
	update_in_insert = false,
	float = {
		header = "",
		source = "always",
		border = "rounded",
		focusable = true,
	},
})

-- Change Error Signs in Gutter
local signs = { Error = "✘", Warn = " ", Hint = "", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
