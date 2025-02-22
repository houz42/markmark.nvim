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

local function find_next_position_of_code_block(current_line, code_blocks)
  for _, code_block in ipairs(code_blocks) do
    if code_block.start > current_line then
      return code_block.start
    end
  end
  return nil
end

local function find_previous_position_of_code_block(current_line, code_blocks)
  for i = #code_blocks, 1, -1 do
    local code_block = code_blocks[i]
    if code_block["end"] < current_line then
      return code_block.start
    end
  end
  return nil
end

function M.jump_to_next_code_block()
  local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1
  local code_blocks = get_all_code_blocks()
  local next_line = find_next_position_of_code_block(current_line, code_blocks)

  if next_line then
    vim.api.nvim_win_set_cursor(0, { next_line + 1, 0 })
  else
    -- Wrap around to the beginning if no next code block is found
    next_line = find_next_position_of_code_block(-1, code_blocks)
    if next_line then
      vim.api.nvim_win_set_cursor(0, { next_line + 1, 0 })
    else
      print("No code blocks found in the document.")
    end
  end
end

function M.jump_to_previous_code_block()
  local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1
  local code_blocks = get_all_code_blocks()
  local prev_line = find_previous_position_of_code_block(current_line, code_blocks)

  if prev_line then
    vim.api.nvim_win_set_cursor(0, { prev_line + 1, 0 })
  else
    -- Wrap around to the end if no previous code block is found
    prev_line = find_previous_position_of_code_block(math.huge, code_blocks)
    if prev_line then
      vim.api.nvim_win_set_cursor(0, { prev_line + 1, 0 })
    else
      print("No code blocks found in the document.")
    end
  end
end

return M
