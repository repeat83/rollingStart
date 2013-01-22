func_mci.speedLimit = function(mci)
	for k,player in pairs(ginfo) do
		if (mci.compcar[player.plid]) and (mci.compcar[player.plid].position == 1) and (mci.compcar[player.plid].speed*360/32768 > 80) and (lim_over ~= player.plid) and (id == 3) then
			luaLFS:bfn(0, 255, 50, 0)
			luaLFS:btn(1, player.ucid, 50, 0, 32, 0, 0, 45, 38, 10, "^C^3Íו במכוו ^180^8^Cךל/ק")
			luaLFS:mst(player.pname.." ^8^C80 on")
			lim_over = player.plid
		elseif (mci.compcar[player.plid]) and (mci.compcar[player.plid].position == 1) and (mci.compcar[player.plid].speed*360/32768 <= 80) and (lim_over == player.plid) then
			luaLFS:bfn(0, 255, 50, 0)
			luaLFS:mst(player.pname.." ^8^C80 off")
			lim_over = 0
		end
	end
end
