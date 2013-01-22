function checkspeed()
	for k,player in pairs(ginfo) do
		if (ginfo[k].plid) and (not ginfo[k].shtraf) and (ginfo[k].speed/32768*360 > 81) then
--debug
luaLFS:btn(1, 255, 100+k, 0, 32+8, 0, 0, 145+k*10-(#ginfo*10), 30, 7, ginfo[k].uname.." ^1 speed >80")
--			luaLFS:mst("/msg ^CШтраф получает "..ginfo[k].uname)
			luaLFS:mst("/p_dt "..ginfo[k].uname)
			ginfo[k].shtraf = true
--debug
		elseif (ginfo[k].plid) and (ginfo[k].shtraf) and (ginfo[k].speed/32768*360 <= 80)  then
luaLFS:bfn(0, 255, 100+k, 0)
		end
	end
end