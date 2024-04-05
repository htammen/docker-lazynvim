-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
	local keys = require("lazy.core.handler").handlers.keys
	---@cast keys LazyKeysHandler
	-- do not create the keymap if a lazy keys handler exists
	if not keys.active[keys.parse({ lhs, mode = mode }).id] then
		opts = opts or {}
		opts.silent = opts.silent ~= false
		if opts.remap and not vim.g.vscode then
			opts.remap = nil
		end
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

map("n", "<leader>ww", "<cmd>write<CR>", { desc = "Save file to disk" })
map("n", "gds", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Show Document Symbols" })
map("n", "<leader>fi", "lua telescope_find_grep()<CR>", { desc = "grep in all files", remap = true })
map("n", "<leader>rr", ':lua require("rest-nvim").run()<cr>', { desc = "Run rest request under cursor" })
-- map("n", "<leader>rn", ":lua vim.lsp.buf.rename()<cr>", { desc = "Rename symbol under cursor" })
