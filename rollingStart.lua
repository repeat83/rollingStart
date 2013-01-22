func_bfn.rollingStart = function(bfn)
	-- для реплеев
	logo(0)
	draw_button(0)
	---------------

	for k,player in pairs(ginfo) do
		if (ginfo[k].ucid == bfn.ucid) and (ginfo[k].admin == 1) then
			logo(bfn.ucid)
			draw_button(bfn.ucid)
		end
	end
	if (bfn.subt == BFN_USER_CLEAR) and (id > 1) then info(buttons[id],10) end
	lim_over = 0
end

func_btc.rollingStart = function(btc)
	if (btc.clickid == 141) then
		clear_menu()
	elseif (btc.clickid == 142) and (not ql) then
		id = 2
--		button = os.time()
		info(buttons[id],30)
	elseif (btc.clickid == 141) and (not ql) then
		id = 5
		button = os.time()
		info(buttons[id],30)		
	elseif (btc.clickid == 143) and (not ql) then
		id = 3
		info(buttons[id],30)
	elseif (btc.clickid == 144) and (not ql) then
		id = 4
		clear_menu()
		-- огриничение 80 удалить
		luaLFS:bfn(0, 255, 50, 0)
		lim_over = 0
		info(buttons[id],30)
--		id = 0
	elseif (btc.clickid == 145) and (not ql) then
		id = 5
		clear_menu()
		-- огриничение 80 удалить
		luaLFS:bfn(0, 255, 50, 0)
		lim_over = 0
--		info(buttons[id],30,10000)


		for i = 1,10 do
			timer.register(i*1000-500,function()
				info("^C-=КРАСНЫЙ ФЛАГ=-",30)
			end)
			timer.register(1000*i,function(id)
				info("^1^C-=КРАСНЫЙ ФЛАГ=-",30)
			end)
		end
		timer.register(15000,function(id)
			info_clear()
		end)
		


		-- сбрасываем красный флаг
		id = 0
	elseif (btc.clickid == 146) and (ql) then
		r_s.garage.state = not r_s.garage.state or nil -- inverse t
		if (r_s.garage.state) then
			buttons[6] = r_s.garage.yes
			luaLFS:mst("/msg "..msg.garage_open)
		else
			buttons[6] = r_s.garage.no
			luaLFS:mst("/msg "..msg.garage_close)
		end
		clear_menu()
--		draw_button(btc.ucid)
	elseif (btc.clickid == 147) and (ql) then
		clear_menu()
		r_s.qualresult.index = os.time()
		luaLFS:tiny(1, TINY_RES)
	end
end

func_mci.rollingStart = function(mci)
--	limit(mci)
--	checkdead(mci)
	--проверить скорость и назначить штрафы
	if (id == -2) then
		checkspeed()
	elseif (id == -1) then
--		checkspeed()
		-- если есть штраф, то его нужно убрать с экрана
		for k,player in pairs(ginfo) do
			if (ginfo[k].shtraf) then
--debug
luaLFS:bfn(0, 255, 100+k, 0)
				ginfo[k].shtraf = nil
			end
		end
		id = 0
	end

--	checktime()
end

func_vtn.rollingStart = function(vtn)
	for k,player in pairs(ginfo) do
		if (vtn.ucid == player.ucid) and (player.admin ~= 1) then luaLFS:tiny(1, TINY_VTC) end
	end
--	info("^2^CНе голосовать!!!",100,3000)
end

func_rst.rollingStart = function(rst)
	info_clear()
	for k,player in pairs(ginfo) do
		-- обнулим данные о
		player.dead = nil
		player.in_pit = nil
		canrace[k] = nil
	end
	if (rst.qualmins > 0) then
		ql = true
		-- при квалификации и запуске скрипта создаём новый файл результатов и запрашиваем их
		print("collect qual result")
		luaLFS:tiny(3, TINY_RES)
	elseif (rst.racelaps > 0) then
		ql = nil
-------------------------------------------------------
		if (rst.reqi ~= 1) then -- если это не инит, значит был рестарт
			id = 2
			info(buttons[id],30)
			luaLFS:mst("/laps=0")
--			local time = 12000 + math.floor(rst.nump/2)*1000
--			time = time + 10000
			time = 34000 -- 34 секунды
			timer.register(time,function()
--				luaLFS:mst("/msg GREEEEEEN")
				luaLFS:mst("/laps="..rst.racelaps)
			end)
		end
------------------------------------------------------
	end
end

func_tiny.rollingStart = function(tiny)
	if (tiny.subt == TINY_REN) then
		info_clear()
		ql = nil
	end
end
