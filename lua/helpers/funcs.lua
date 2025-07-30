local M = {}

-- Function that returns the keys of a table
function M.keys(t)
	local result = {}
	for k, _ in pairs(t) do
		table.insert(result, k)
	end
	return result
end

-- Overwrites or adds each value of t2 to a copy of t1
function M.merge(t1, t2)
	local result = {}
	-- copy t1 into result
	for k, v in pairs(t1) do
		result[k] = v
	end
	-- override or add value from t2 to t1
	for k, v in pairs(t2) do
		result[k] = v
	end
	return result
end

return M
