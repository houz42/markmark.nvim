local Utils = require("markmark.utils")
local M = {}

local function get_all_code_blocks()
	local code_blocks = {}
	local in_code_block = false
	local block_start = nil

	local content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
	for i, line in ipairs(vim.split(content, "\n")) do
		-- Trim leading spaces before checking for the code block marker
		local trimmed_line = line:match("^%s*(.-)$")
		if trimmed_line:match("^```") then
			if in_code_block then
				-- End of code block
				table.insert(code_blocks, { start = block_start, ["end"] = i })
				in_code_block = false
			else
				-- Start of code block
				block_start = i
				in_code_block = true
			end
		end
	end

	return code_blocks
end

function M.jump_to_next_code_block()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local code_blocks = get_all_code_blocks()
	local next_line = Utils.find_next_position(current_line, code_blocks)

	-- Print each header
	for _, header in ipairs(code_blocks) do
		print("Code block start: " .. header.start .. ", end: " .. header["end"])
	end

	if next_line then
		vim.api.nvim_win_set_cursor(0, { next_line + 1, 0 })
	else
		print("No code blocks found in the document.")
	end
end

function M.jump_to_previous_code_block()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local code_blocks = get_all_code_blocks()
	local prev_line = Utils.find_previous_position(current_line, code_blocks)

	if prev_line then
		vim.api.nvim_win_set_cursor(0, { prev_line + 1, 0 })
	else
		print("No code blocks found in the document.")
	end
end

return M
