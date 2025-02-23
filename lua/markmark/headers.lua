local Utils = require("markmark.utils")
local M = {}

-- Function to get all headers in the document
local function get_all_headers()
	local headers = {}
	local content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
	for i, line in ipairs(vim.split(content, "\n")) do
		if line:match("^#+") then
			table.insert(headers, { start = i, ["end"] = i }) -- Insert table with start and end
		end
	end

	return headers
end

function M.jump_to_next_header()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local headers = get_all_headers()

	local next_line = Utils.find_next_position(current_line, headers)

	if next_line then
		vim.api.nvim_win_set_cursor(0, { next_line, 0 })
	else
		print("No headers found in the document.")
	end
end

function M.jump_to_previous_header()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local headers = get_all_headers()
	local prev_line = Utils.find_previous_position(current_line, headers)

	if prev_line then
		vim.api.nvim_win_set_cursor(0, { prev_line, 0 })
	else
		print("No headers found in the document.")
	end
end

return M
