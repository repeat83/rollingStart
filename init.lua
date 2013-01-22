func_connected.rollingStart = function()
	lim_over = 0
	canrace = {}
	
	r_s = {}
	r_s.garage = {}
	r_s.garage.state = true
	r_s.garage.yes = "^CУход в гараж на квал.: ^2Да"
	r_s.garage.no = "^CУход в гараж на квал.: ^1Нет"
	
	
	msg = {}
	msg.garage_open = "^6Garage ^2opened!"
	msg.garage_close = "^6Garage ^1closed! NO ^3SHIFT+P(S)"
	
	-- таблица результатов квалификации
	r_s.qualresult = {}
	
	id = 0
	buttons = {}
	buttons[1] = "^CЗакрыть"
	buttons[2] = "^6^CФОРМИРОВОЧНЫЙ КРУГ"
	buttons[3] = "^3^CСКОРОСТЬ 80КМ/Ч ВНИМАНИЕ"
	buttons[4] = "^2^C-=ЗЕЛЕНЫЙ ФЛАГ=-"
	buttons[5] = "^1^C-=КРАСНЫЙ ФЛАГ=-"
	buttons[6] = r_s.garage.yes
	buttons[7] = "^CРезультаты квалификации"
	
	luaLFS:small(0, SMALL_NLI, 100)
	luaLFS:tiny(1, TINY_NCN)
	luaLFS:tiny(1, TINY_RST)
	luaLFS:tiny(1, TINY_NPL)
	luaLFS:mst("/msg ^6Rolling Start v0.4 ^7(c) ^3repeat")
--	conf_serv()
end

func_ncn.rollingStart = function(ncn)
	if (ncn.admin == 1) then logo(ncn.ucid) end
end

func_npl.rollingStart = function(npl)
	for k,player in pairs(ginfo) do
		if (player.ucid == npl.ucid) then
			local noaccess = checkname(ginfo[k])

			if (noaccess) then 
				luaLFS:mst(noaccess)
				luaLFS:mst("/spec "..npl.pname)
			elseif (canrace[k] == nil) then
				canrace[k] = os.time()
			elseif (ql) and (canrace[k]) and (not r_s.garage.state) then
				luaLFS:mtc(0,255,0,(ginfo[k].pname).." ^3you can't resume qual after shift+p(s)")
				luaLFS:mst("/spec "..npl.pname)
			end
			break
		end
	end
end

func_pll.rollingStart = function(pll)
	for k,player in pairs(ginfo) do
		if (player.plid == pll.plid) then
			ginfo[k].dead = nil
			ginfo[k].in_pit = nil
			canrace[k] = os.time()
			break
		end
	end
end

func_cnl.rollingStart = function(cnl)
	for k,player in pairs(ginfo) do
		if (player.ucid == cnl.ucid) then
-- если игрок катается и потерял соединение, он может ещё раз провести квалификацию
			if ((cnl.reason == 1) or (cnl.reason == 2)) and ((canrace[k]+1) >= os.time()) then
				canrace[k] = nil
			end
			break
		end
	end
end

func_pla.rollingStart = function(pla)
	for k,player in pairs(ginfo) do
		if (player.plid == pla.plid) and (pla.fact ~=0) then
			print("player "..ginfo[k].pname.." enter pit stop")
			ginfo[k].in_pit = true
			break
		elseif (player.plid == pla.plid) and (pla.fact == 0) then
			print("player "..ginfo[k].pname.." leave pit stop")
			ginfo[k].in_pit = nil
			break
		end
	end
end

func_plp.rollingStart = function(plp)
	for k,player in pairs(ginfo) do
		if (player.plid == plp.plid) then
			print("player "..ginfo[k].pname.." enter garage")
			canrace[k]= os.time()
			break
		end
	end
end
