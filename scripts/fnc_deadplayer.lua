function checkdead(mci)
	for k,player in pairs(ginfo) do
		if (mci.compcar[player.plid]) and (mci.compcar[player.plid].speed*360/32768 < 0.1) and (player.dead == nil) and (not player.in_pit) then
print("dead on "..player.pname)
			ginfo[k].dead = os.time()
		end
		if (mci.compcar[player.plid]) and ((mci.compcar[player.plid].speed*360/32768 > 0.1) or (player.in_pit)) and (player.dead) then
print("dead off "..player.pname)
			ginfo[k].dead = nil
		end
	end
end

function checktime()
	for k,player in pairs(ginfo) do
		if (player.dead) and (player.dead+40 < os.time()) then luaLFS:mst("/spec "..player.pname) end
	end
end