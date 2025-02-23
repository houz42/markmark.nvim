-- Require the separate modules
local headers = require("markmark.headers")
local code_blocks = require("markmark.code_blocks")
local tables = require("markmark.tables")

local M = {}

-- Function to set commands for files
local function set_commands()
	vim.api.nvim_buf_create_user_command(0, "MarkMarkNextHeader", headers.jump_to_next_header, {})
	vim.api.nvim_buf_create_user_command(0, "MarkMarkPrevHeader", headers.jump_to_previous_header, {})
	vim.api.nvim_buf_create_user_command(0, "MarkMarkNextCode", code_blocks.jump_to_next_code_block, {})
	vim.api.nvim_buf_create_user_command(0, "MarkMarkPrevCode", code_blocks.jump_to_previous_code_block, {})
	vim.api.nvim_buf_create_user_command(0, "MarkMarkNextTable", tables.jump_to_next_table, {})
	vim.api.nvim_buf_create_user_command(0, "MarkMarkPrevTable", tables.jump_to_previous_table, {})
end

-- Function to set default keybindings
local function set_default_keybindings()
	local default_keybindings = {
		{ "]#", ":MarkMarkNextHeader<CR>", desc = "Next Header" },
		{ "[#", ":MarkMarkPrevHeader<CR>", desc = "Previous Header" },
		{ "]`", ":MarkMarkNextCode<CR>", desc = "Next Code Block" },
		{ "[`", ":MarkMarkPrevCode<CR>", desc = "Previous Code Block" },
		{ "]|", ":MarkMarkNextTable<CR>", desc = "Next Table" },
		{ "[|", ":MarkMarkPrevTable<CR>", desc = "Previous Table" },
	}

	local wk = require("which-key")

	-- Register keybindings with which-key using add
	wk.add(default_keybindings, { mode = "n" })
end

-- Setup function to initialize the plugin
function M.setup(opts)
	-- Setup commands for any filetype, relying on user configuration to specify when the plugin is active
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "*",
		callback = function()
			set_commands()
			set_default_keybindings()
		end,
	})
end

return M
