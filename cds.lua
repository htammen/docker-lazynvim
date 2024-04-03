vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.cds" },
	command = "set filetype=cds",
})
require("lspconfig").cds_lsp.setup({})

-- Install tree-sitter-cds for syntax highlighting
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.cds = {
	install_info = {
		-- local path or git repo
		-- url = '/path/to/tree-sitter-cds',
		url = "https://github.com/cap-js-community/tree-sitter-cds.git",
		files = { "src/parser.c", "src/scanner.c" },
		branch = "main",
		generate_requires_npm = false,
		requires_generate_from_grammar = false,
	},
	filetype = "cds",
	-- additional filetypes that use this parser
	used_by = { "cdl", "hdbcds" },
}

vim.cmd("TSInstall cds")

-- set colorscheme to evening cause Default scheme tokionight, which is great for most filetypes, looks
-- awful for cds files
vim.cmd("colorscheme evening")

-- -- retrieve the content of a URL
-- This could be used to copy the scm files from inside the container dynamically
-- At the moment the scm files for tree-sitter-cds are copied when the image is build.
-- If the tree-sitter-cds team adds additional scm files to the repo these are not detected
-- automatically.
--
-- local nvimconfigpath = vim.fn.stdpath("config")
-- local cdsTreeSitterPath = "" .. nvimconfigpath .. "/queries/cds"
-- vim.notify("cdsTreeSitterPath: " .. cdsTreeSitterPath, vim.log.levels.WARN)
-- vim.cmd("!mkdir -p " .. cdsTreeSitterPath)
--
-- local http = require("socket.http")
-- local body, code = http.request("https://github.com/cap-js-community/tree-sitter-cds/raw/main/nvim/locals.scm")
-- if not body then
-- 	error(code)
-- end
-- -- save the content to a file
-- local f = assert(io.open(cdsTreeSitterPath .. "/locals.scm", "wb")) -- open in "binary" mode
-- f:write(body)
-- f:close()

-- I left the following code in this file cause it helps me to understand how lspconfig works and
-- how it can be adjusted
-- This content is no longer used
--
-- local lspconfig = require("lspconfig")
-- local configs = require("lspconfig.configs")
-- local on_attach = function(client, bufnr)
--   vim.notify("sapcds_lsp attached to buffer", vim.log.levels.WARN)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
--   if client.server_capabilities.documentFormattingProvider then
--     vim.cmd("nnoremap <silent><buffer> gf :lua vim.lsp.buf.format({async = true})<CR>")
--   end
--
--   if client.server_capabilities.documentRangeFormattingProvider then
--     vim.cmd("xnoremap <silent><buffer> gf :lua vim.lsp.buf.range_formatting({})<CR>")
--   end
-- end
--
-- configs.sapcds_lsp = {
--   default_config = {
--     --     cmd = { vim.fn.expand("/home/helmut/.volta/bin/cds-lsp --stdio") }, -- this executable must be there
--     --     filetypes = { "cds" },
--     --     root_dir = function(fname)
--     --       vim.notify("get cwd", vim.log.levels.WARN)
--     --       cwd = vim.fn.getcwd()
--     --       vim.notify("cwd = " + cwd, vim.log.levels.WARN)
--     --       return vim.fn.getcwd()
--     --     end,
--     --     settings = {},
--   },
-- }
--
-- function serializeTable(val, name, skipnewlines, depth)
--   skipnewlines = skipnewlines or false
--   depth = depth or 0
--
--   local tmp = string.rep(" ", depth)
--   if name then
--     if not string.match(name, "^[a-zA-z_][a-zA-Z0-9_]*$") then
--       name = string.gsub(name, "'", "\\'")
--       name = "['" .. name .. "']"
--     end
--     tmp = tmp .. name .. " = "
--   end
--
--   if type(val) == "table" then
--     tmp = tmp .. "{" .. (not skipnewlines and "\n" or "")
--
--     for k, v in pairs(val) do
--       tmp = tmp .. serializeTable(v, k, skipnewlines, depth + 1) .. "," .. (not skipnewlines and "\n" or "")
--     end
--
--     tmp = tmp .. string.rep(" ", depth) .. "}"
--   elseif type(val) == "number" then
--     tmp = tmp .. tostring(val)
--   elseif type(val) == "string" then
--     tmp = tmp .. string.format("%q", val)
--   elseif type(val) == "boolean" then
--     tmp = tmp .. (val and "true" or "false")
--   else
--     tmp = tmp .. '"[inserializeable datatype:' .. type(val) .. ']"'
--   end
--
--   return tmp
-- end
--
-- -- if lspconfig.sapcds_lsp.setup then
-- vim.notify("Calling sapcds_lsp setup", vim.log.levels.WARN)
-- local cds_config = {
--   capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
--   cmd = { vim.fn.expand("/home/helmut/.volta/bin/cds-lsp)"), "--stdio" }, -- this executable must be there
--   filetypes = { "cds" },
--   root_dir = function(fname)
--     vim.notify("get cwd", vim.log.levels.WARN)
--     local cwd = vim.fs.dirname(vim.fs.find({ ".cdsrc.json", "package.json" }, { upward = true })[1])
--     vim.notify("cwd = " + cwd, vim.log.levels.WARN)
--     return cwd
--   end,
--   on_attach = function(client, bufnr)
--     vim.notify("sapcds_lsp attached to buffer", vim.log.levels.WARN)
--     local function buf_set_option(...)
--       vim.api.nvim_buf_set_option(bufnr, ...)
--     end
--     buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
--     if client.server_capabilities.documentFormattingProvider then
--       vim.cmd("nnoremap <silent><buffer> gf :lua vim.lsp.buf.format({async = true})<CR>")
--     end
--
--     if client.server_capabilities.documentRangeFormattingProvider then
--       vim.cmd("xnoremap <silent><buffer> gf :lua vim.lsp.buf.range_formatting({})<CR>")
--     end
--   end,
--   autostart = true,
-- }
-- -- vim.notify(serializeTable(cds_config))
-- lspconfig.sapcds_lsp.setup(cds_config)
-- local cds_cfg = lspconfig.sapcds_lsp
-- vim.notify(serializeTable(cds_cfg))
-- vim.notify("Called sapcds_lsp setup", vim.log.levels.WARN)
-- -- end
--
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local bufnr = args.buf
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     vim.notify("bufnr = " .. bufnr, vim.log.levels.WARN)
--     vim.notify("client = " .. args.data.client_id, vim.log.levels.WARN)
--   end,
-- })
