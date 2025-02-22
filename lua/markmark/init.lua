-- Require the separate modules
local headers = require("markmark.headers")
local code_blocks = require("markmark.code_blocks")
local keybindings = require("markmark.keybindings")
local tables = require("markmark.tables")

-- Function to set commands for markdown files
local function set_markdown_commands()
	-- Command to jump to the next header
	vim.api.nvim_buf_create_user_command(0, "MarkMarkNextHeader", headers.jump_to_next_header, {})

	-- Command to jump to the previous header
	vim.api.nvim_buf_create_user_command(0, "MarkMarkPrevHeader", headers.jump_to_previous_header, {})

	-- Command to jump to the next code block
	vim.api.nvim_buf_create_user_command(0, "MarkMarkNextCode", code_blocks.jump_to_next_code_block, {})

	-- Command to jump to the previous code block
	vim.api.nvim_buf_create_user_command(0, "MarkMarkPrevCode", code_blocks.jump_to_previous_code_block, {})

	-- Command to jump to the next table
	vim.api.nvim_buf_create_user_command(0, "MarkMarkNextTable", tables.jump_to_next_table, {})

	-- Command to jump to the previous table
	vim.api.nvim_buf_create_user_command(0, "MarkMarkPrevTable", tables.jump_to_previous_table, {})
end

-- Setup function to initialize the plugin
local function setup(opts)
	-- Initialize keybindings with options
	keybindings.setup(opts)

	-- Setup commands and keybindings only for markdown files
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "markdown",
		callback = function()
			set_markdown_commands()
			keybindings.set_markdown_keybindings()
		end,
	})
end

-- Return the setup function for Lazy.nvim
return {
	setup = setup,
}
