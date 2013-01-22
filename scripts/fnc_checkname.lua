function checkname(player)
	names = readusers()
	for _, name in pairs(names) do
		if (player.uname:lower() == name[1]:lower()) then
			if (player.cname:lower() ~= name[2]:lower()) then
				return "/msg ^7"..player.pname.." ^7wrong car. Use "..name[2]:upper()
			elseif (player.h_mass ~= tonumber(name[3])) then
				return "/msg ^7"..player.pname.." ^7"..name[2]:upper().." "..name[3].." kg"
			elseif (player.h_tres ~= tonumber(name[4])) then
				return "/msg ^7"..player.pname.." ^7"..name[2]:upper().." "..name[4].." restrict"
			end
			return false
		end
	end
	return "/msg ^7"..player.pname.." ^7you not have access to event."
end

function readusers()
	local users = {}
	local file = assert(io.open("access.txt", "r+"))
	for line in file:lines() do
		table.insert(users,{line:match("(.+),(.+),(.+),(.+)")})
	end
	file:close()
	return users
end
