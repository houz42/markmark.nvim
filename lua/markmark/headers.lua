local M = {}

-- Function to flatten the symbol tree
local function flatten_symbols(symbols, kind)
  local flat_symbols = {}
  local function traverse(symbols)
    for _, symbol in ipairs(symbols) do
      if symbol.kind == kind then
        table.insert(flat_symbols, symbol)
      end
      if symbol.children then
        traverse(symbol.children)
      end
    end
  end
  traverse(symbols)
  return flat_symbols
end

-- Helper function to find the next position of a specific kind
local function find_next_position_of_kind(current_line, symbols, kind)
  local flat_symbols = flatten_symbols(symbols, kind)
  for _, symbol in ipairs(flat_symbols) do
    if symbol.range.start.line > current_line and symbol.kind == kind then
      return symbol.range.start.line, symbol.range.start.character
    end
  end
  return nil
end

-- Helper function to find the previous position of a specific kind
local function find_previous_position_of_kind(current_line, symbols, kind)
  local flat_symbols = flatten_symbols(symbols, kind)
  for i = #flat_symbols, 1, -1 do
    local symbol = flat_symbols[i]
    if symbol.range.start.line < current_line and symbol.kind == kind then
      return symbol.range.start.line, symbol.range.start.character
    end
  end
  return nil
end

function M.jump_to_next_header()
  local params = vim.lsp.util.make_position_params()
  vim.lsp.buf_request(0, "textDocument/documentSymbol", params, function(err, result, ctx, _)
    if err then
      print("Error fetching symbols: ", err)
      return
    end

    local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1
    local next_line, next_char = find_next_position_of_kind(current_line, result, 15) -- 15 is the kind for headers

    if next_line then
      vim.api.nvim_win_set_cursor(0, { next_line + 1, next_char })
    else
      -- If no next header is found, wrap around to the beginning
      next_line, next_char = find_next_position_of_kind(-1, result, 15)
      if next_line then
        vim.api.nvim_win_set_cursor(0, { next_line + 1, next_char })
      else
        print("No headers found in the document.")
      end
    end
  end)
end

function M.jump_to_previous_header()
  local params = vim.lsp.util.make_position_params()
  vim.lsp.buf_request(0, "textDocument/documentSymbol", params, function(err, result, ctx, _)
    if err then
      print("Error fetching symbols: ", err)
      return
    end
    local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1
    local prev_line, prev_char = find_previous_position_of_kind(current_line, result, 15) -- 15 is the kind for headers

    if prev_line then
      vim.api.nvim_win_set_cursor(0, { prev_line + 1, prev_char })
    else
      -- If no previous header is found, wrap around to the end
      prev_line, prev_char = find_previous_position_of_kind(math.huge, result, 15)
      if prev_line then
        vim.api.nvim_win_set_cursor(0, { prev_line + 1, prev_char })
      else
        print("No headers found in the document.")
      end
    end
  end)
end

return M
