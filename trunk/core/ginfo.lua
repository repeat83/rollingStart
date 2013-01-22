print "Loading GINFO module 0.7"

ginfo = {}

func_connected.ginfo = function()
	luaLFS:tiny(1, TINY_NCN)
	luaLFS:tiny(1, TINY_NPL)
	luaLFS:mst("/msg ^3ginfo module ^7(c) ^3repeat")
end

func_ncn.ginfo = function(ncn)
	if (ncn.ucid ~= 0) then
		table.insert(ginfo,{ucid = ncn.ucid, uname = ncn.uname, pname = ncn.pname, admin = ncn.admin})
	end
end

func_npl.ginfo = function(npl)
	for k,player in pairs(ginfo) do
		if (player.ucid == npl.ucid) then
			--сбор всех данных от пакета в ginfo игрока
			for _k,_v in pairs(npl) do ginfo[k][_k] = _v end
			break
		end
	end
end

func_cpr.ginfo = function(cpr)
	for k,player in pairs(ginfo) do
		if (player.ucid == cpr.ucid) then
			print("player "..ginfo[k].pname.." change name to "..cpr.pname)
			ginfo[k].pname = cpr.pname
			break
		end
	end
end

func_pll.ginfo = function(pll)
	for k,player in pairs(ginfo) do
		if (player.plid == pll.plid) then
			print("player "..ginfo[k].pname.." leave track")
			ginfo[k].plid = nil
			break
		end
	end
end

func_plp.ginfo = function(plp)
	for k,player in pairs(ginfo) do
		if (player.plid == plp.plid) then
			print("player "..ginfo[k].pname.." go to garage (plid=nil???)")
--			ginfo[k].plid = nil
			break
		end
	end
end

func_cnl.ginfo = function(cnl)
	for k,player in pairs(ginfo) do
		if (player.ucid == cnl.ucid) then
			print("player "..ginfo[k].pname.." leave server")
			table.remove(ginfo,k)
			break
		end
	end
end

--func_pla.ginfo = function(pla)
--end

func_mci.ginfo = function(mci)
-- update ginfo
	for k,player in pairs(ginfo) do
		if (mci.compcar[player.plid]) then
			for _k,_v in pairs((mci.compcar[player.plid])) do ginfo[k][_k] = _v end
		end
	end
end

-- проверить работоспособность!!!
func_toc.ginfo = function(toc)
	for k,player in pairs(ginfo) do
		if (player.plid == toc.plid) then
			ginfo[k].ucid = toc.newucid
		end
	end
end

