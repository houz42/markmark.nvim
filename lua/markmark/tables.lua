local Utils = require("markmark.utils")
local M = {}

local function get_all_tables()
	local tables = {}
	local in_table = false
	local table_start = nil

	local content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
	for i, line in ipairs(vim.split(content, "\n")) do
		-- Trim leading spaces before checking for the table marker
		local trimmed_line = line:match("^%s*(.-)$")
		if trimmed_line:match("^|") then
			if not in_table then
				-- Start of table
				table_start = i
				in_table = true
			end
		elseif in_table then
			-- End of table
			table.insert(tables, { start = table_start, ["end"] = i - 1 })
			in_table = false
		end
	end

	return tables
end

function M.jump_to_next_table()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local tables = get_all_tables()
	local next_line = Utils.find_next_position(current_line, tables)

	if next_line then
		vim.api.nvim_win_set_cursor(0, { next_line, 0 })
	else
		print("No tables found in the document.")
	end
end

function M.jump_to_previous_table()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local tables = get_all_tables()
	local prev_line = Utils.find_previous_position(current_line, tables)

	if prev_line then
		vim.api.nvim_win_set_cursor(0, { prev_line, 0 })
	else
		print("No tables found in the document.")
	end
end

return M
