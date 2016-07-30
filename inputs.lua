local M = {}


---Parses the output of the `sensors` command and returns it as a table
function M.sensors()
	local ret, i = {}, 1
	local source
	local class
	for line in assert( io.popen( 'sensors -u', 'r' )):lines() do
		if #line~=0 then
			local ws, k, v = line:match'^(%s*)(.*)%s*:%s*(.*)%s*$'
			if not ws then
				source = {}
				ret[ line ] = source
			elseif #v==0 then
				class = {}
				source[ k ] = class
			elseif #ws>0 then
				class[ k ] = v
			else
				source[ k ] = v
			end
		end
	end
	return ret
end

return M
