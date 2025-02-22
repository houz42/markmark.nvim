local M = {}

-- Function to get all headers in the document
local function get_all_headers()
	local headers = {}
	local content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
	for i, line in ipairs(vim.split(content, "\n")) do
		-- Trim leading spaces before checking for the header marker
		local trimmed_line = line:match("^%s*(.-)$")
		if trimmed_line:match("^#+") then
			table.insert(headers, i)
		end
	end
	return headers
end

-- Helper function to find the next header position
local function find_next_position_of_header(current_line, headers)
	for _, header_line in ipairs(headers) do
		if header_line > current_line then
			return header_line
		end
	end
	return nil
end

-- Helper function to find the previous header position
local function find_previous_position_of_header(current_line, headers)
	for i = #headers, 1, -1 do
		local header_line = headers[i]
		if header_line < current_line then
			return header_line
		end
	end
	return nil
end

function M.jump_to_next_header()
	local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1
	local headers = get_all_headers()
	local next_line = find_next_position_of_header(current_line, headers)

	if next_line then
		vim.api.nvim_win_set_cursor(0, { next_line + 1, 0 })
	else
		-- Wrap around to the beginning if no next header is found
		next_line = find_next_position_of_header(-1, headers)
		if next_line then
			vim.api.nvim_win_set_cursor(0, { next_line + 1, 0 })
		else
			print("No headers found in the document.")
		end
	end
end

function M.jump_to_previous_header()
	local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1
	local headers = get_all_headers()
	local prev_line = find_previous_position_of_header(current_line, headers)

	if prev_line then
		vim.api.nvim_win_set_cursor(0, { prev_line + 1, 0 })
	else
		-- Wrap around to the end if no previous header is found
		prev_line = find_previous_position_of_header(math.huge, headers)
		if prev_line then
			vim.api.nvim_win_set_cursor(0, { prev_line + 1, 0 })
		else
			print("No headers found in the document.")
		end
	end
end

return M
