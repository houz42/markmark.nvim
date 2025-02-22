local Utils = {}

function Utils.find_next_position(current_line, positions)
	for _, position in ipairs(positions) do
		if position.start > current_line then
			return position.start
		end
	end
	-- Wrap around to the beginning if no next position is found
	if #positions > 0 then
		return positions[1].start
	end
	return nil
end

function Utils.find_previous_position(current_line, positions)
	for i = #positions, 1, -1 do
		local position = positions[i]
		if position.start < current_line then
			return position.start
		end
	end
	-- Wrap around to the end if no previous position is found
	for i = #positions, 1, -1 do
		local position = positions[i]
		if position.start < math.huge then -- Ensure we don't loop indefinitely
			return position.start
		end
		if position.start <= current_line then
			return nil
		end
	end
	return nil
end

return Utils
