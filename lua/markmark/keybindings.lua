local M = {}

function M.setup(opts)
	opts = opts or {}
	local keybindings = opts.keybindings
		or {
			next_header = "]#",
			prev_header = "[#",
			next_code = "]`",
			prev_code = "[`",
			next_table = "]|",
			prev_table = "[|",
		}

	-- Function to set keybindings for markdown files
	function M.set_markdown_keybindings()
		print("Setting markdown keybindings")
		vim.api.nvim_buf_set_keymap(
			0,
			"n",
			keybindings.next_header,
			":MarkMarkNextHeader<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_buf_set_keymap(
			0,
			"n",
			keybindings.prev_header,
			":MarkMarkPrevHeader<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_buf_set_keymap(
			0,
			"n",
			keybindings.next_code,
			":MarkMarkNextCode<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_buf_set_keymap(
			0,
			"n",
			keybindings.prev_code,
			":MarkMarkPrevCode<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_buf_set_keymap(
			0,
			"n",
			keybindings.next_table,
			":MarkMarkNextTable<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_buf_set_keymap(
			0,
			"n",
			keybindings.prev_table,
			":MarkMarkPrevTable<CR>",
			{ noremap = true, silent = true }
		)
	end
end

return M
