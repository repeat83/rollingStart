print "Loading Function module 1.21"

	function err(err_text)
		err_text = os.date("%d/%m/%y %H:%M:%S").." "..err_text.."\n"
		io.write(err_text)
		local f = assert(io.open("log\\error.log", "a+"))
		f:write(err_text)
		f:close()
	end  


	func_thread = {}

	func_connected = {}
	func_tiny = {}
	func_small = {}
	func_sta = {}
	func_sch = {}
	func_sfp = {}
	func_scc = {}
	func_cpp = {}
	func_ism = {}
	func_mso = {}
	func_iii = {}
	func_mst = {}
	func_mtc = {}
	func_mod = {}
	func_vtn = {}
	func_rst = {}
	func_ncn = {}
	func_cnl = {}
	func_cpr = {}
	func_npl = {}
	func_plp = {}
	func_pll = {}
	func_lap = {}
	func_spx = {}
	func_pit = {}
	func_psf = {}
	func_pla = {}
	func_cch = {}
	func_pen = {}
	func_toc = {}
	func_flg = {}
	func_pfl = {}
	func_fin = {}
	func_res = {}
	func_reo = {}
	func_nlp = {}
	func_mci = {}
	func_msx = {}
	func_msl = {}
	func_crs = {}
	func_bfn = {}
	func_axi = {}
	func_axo = {}
	func_btn = {}
	func_btc = {}
	func_btt = {}


function thread()
	for tname, thread in pairs(func_thread) do
--		io.write ("THREAD "..tname)
		--переделываем функцию в поток
		if type(func_thread[tname]) ~= "thread" then
			func_thread[tname] = coroutine.create(func_thread[tname])
		end
		coroutine.resume(func_thread[tname])
--		io.write (" done\n")
	end
end
evt_bind(EVT_THREAD, thread)


function connected()
	for fname, func in pairs(func_connected) do
		io.write ("CONNECTED "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(EVT_CONNECTED, connected)

function tiny(imsg)
	local msg = luaLFS:tiny(imsg)
	for fname, func in pairs(func_tiny) do
		io.write ("TINY "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_TINY, tiny)

function small(imsg)
	local msg = luaLFS:small(imsg)
	for fname, func in pairs(func_small) do
		io.write ("SMALL "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_SMALL, small)

function sta(imsg)
	local msg = luaLFS:sta(imsg)
	for fname, func in pairs(func_sta) do
		io.write ("STA "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_STA, sta)

function sch(imsg)
	local msg = luaLFS:sch(imsg)
	for fname, func in pairs(func_sch) do
		io.write ("SCH "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_SCH, sch)

function sfp(imsg)
	local msg = luaLFS:sfp(imsg)
	for fname, func in pairs(func_sfp) do
		io.write ("SFP "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_SFP, sfp)

function scc(imsg)
	local msg = luaLFS:scc(imsg)
	for fname, func in pairs(func_scc) do
		io.write ("SCC "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_SCC, scc)

function cpp(imsg)
	local msg = luaLFS:cpp(imsg)
	for fname, func in pairs(func_cpp) do
		io.write ("CPP "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_CPP, cpp)

function ism(imsg)
	local msg = luaLFS:ism(imsg)
	for fname, func in pairs(func_ism) do
		io.write ("ISM "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_ISM, ism)

function mso(imsg)
	local msg = luaLFS:mso(imsg)
	for fname, func in pairs(func_mso) do
		io.write ("MSO "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_MSO, mso)

function iii(imsg)
	local msg = luaLFS:iii(imsg)
	for fname, func in pairs(func_iii) do
		io.write ("III "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_III, iii)

function mst(imsg)
	local msg = luaLFS:mst(imsg)
	for fname, func in pairs(func_mst) do
		io.write ("MST "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_MST, mst)

function mtc(imsg)
	local msg = luaLFS:mtc(imsg)
	for fname, func in pairs(func_mtc) do
		io.write ("MTC "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_MTC, mtc)

function mod(imsg)
	local msg = luaLFS:mod(imsg)
	for fname, func in pairs(func_mod) do
		io.write ("MOD "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_MOD, mod)

function vtn(imsg)
	local msg = luaLFS:vtn(imsg)
	for fname, func in pairs(func_vtn) do
		io.write ("VTN "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_VTN, vtn)

function rst(imsg)
	local msg = luaLFS:rst(imsg)
	for fname, func in pairs(func_rst) do
		io.write ("RST "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_RST, rst)

function ncn(imsg)
	local msg = luaLFS:ncn(imsg)
	for fname, func in pairs(func_ncn) do
		io.write ("NCN "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_NCN, ncn)

function cnl(imsg)
	-- функция ginfo должна выполнится самой последней из всех доступных функций, т.к. удаляет данные из таблицы ginfo
	local msg = luaLFS:cnl(imsg)
	for fname, func in pairs(func_cnl) do
		-- выполняем сперва все функиции кроме ginfo
		if (fname ~= "ginfo") then
			io.write ("CNL "..fname)
			local status, error = pcall(func,msg)
			if (error) then err(error) end
			io.write (" done\n")
		end
	end
	-- выполняем ginfo функцию последней
	io.write ("CNL ginfo")
	func_cnl.ginfo(msg)
	io.write (" done\n")
end
evt_bind(ISP_CNL, cnl)

function cpr(imsg)
	local msg = luaLFS:cpr(imsg)
	for fname, func in pairs(func_cpr) do
		io.write ("CPR "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_CPR, cpr)

function npl(imsg)
	local msg = luaLFS:npl(imsg)
	for fname, func in pairs(func_npl) do
		io.write ("NPL "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_NPL, npl)

function plp(imsg)
	-- функция должна самой выполнится последний из всех доступных функций, т.к. удаляет данные из таблицы ginfo
	local msg = luaLFS:plp(imsg)
	for fname, func in pairs(func_plp) do
		if (fname ~= "ginfo") then
			io.write ("PLP "..fname)
			local status, error = pcall(func,msg)
			if (error) then err(error) end
			io.write (" done\n")
		end
	end
	io.write ("PLP ginfo")
	func_plp.ginfo(msg)
	io.write (" done\n")
end
evt_bind(ISP_PLP, plp)

function pll(imsg)
	-- функция должна самой выполнится последний из всех доступных функций, т.к. удаляет данные из таблицы ginfo
	local msg = luaLFS:pll(imsg)
	for fname, func in pairs(func_pll) do
		if (fname ~= "ginfo") then
			io.write ("PLL "..fname)
			local status, error = pcall(func,msg)
			if (error) then err(error) end
			io.write (" done\n")
		end
	end
	io.write ("PLL ginfo")
	func_pll.ginfo(msg)
	io.write (" done\n")
end
evt_bind(ISP_PLL, pll)

function lap(imsg)
	local msg = luaLFS:lap(imsg)
	for fname, func in pairs(func_lap) do
		io.write ("LAP "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_LAP, lap)

function spx(imsg)
	local msg = luaLFS:spx(imsg)
	for fname, func in pairs(func_spx) do
		io.write ("SPX "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_SPX, spx)

function pit(imsg)
	local msg = luaLFS:pit(imsg)
	for fname, func in pairs(func_pit) do
		io.write ("PIT "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_PIT, pit)

function psf(imsg)
	local msg = luaLFS:psf(imsg)
	for fname, func in pairs(func_psf) do
		io.write ("PSF "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_PSF, psf)

function pla(imsg)
	local msg = luaLFS:pla(imsg)
	for fname, func in pairs(func_pla) do
		io.write ("PLA "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_PLA, pla)

function cch(imsg)
	local msg = luaLFS:cch(imsg)
	for fname, func in pairs(func_cch) do
		io.write ("CHH "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_CCH, cch)

function pen(imsg)
	local msg = luaLFS:pen(imsg)
	for fname, func in pairs(func_pen) do
		io.write ("PEN "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_PEN, pen)

function toc(imsg)
	local msg = luaLFS:toc(imsg)
	for fname, func in pairs(func_toc) do
		io.write ("TOC "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_TOC, toc)

function flg(imsg)
	local msg = luaLFS:flg(imsg)
	for fname, func in pairs(func_flg) do
		io.write ("FLG "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_FLG, flg)

function pfl(imsg)
	local msg = luaLFS:pfl(imsg)
	for fname, func in pairs(func_pfl) do
		io.write ("PFL "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_PFL, pfl)

function fin(imsg)
	local msg = luaLFS:fin(imsg)
	for fname, func in pairs(func_fin) do
		io.write ("FIN "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_FIN, fin)

function res(imsg)
	local msg = luaLFS:res(imsg)
	for fname, func in pairs(func_res) do
		io.write ("RES "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_RES, res)

function reo(imsg)
	local msg = luaLFS:reo(imsg)
	for fname, func in pairs(func_reo) do
		io.write ("REO "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_REO, reo)

function nlp(imsg)
	local msg = luaLFS:nlp(imsg)
	for fname, func in pairs(func_nlp) do
		io.write ("NLP "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_NLP, nlp)

function mci(imsg)
	local msg = luaLFS:mci(imsg)
	for fname, func in pairs(func_mci) do
--		io.write ("MCI "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
--		io.write (" done\n")
	end
end
evt_bind(ISP_MCI, mci)

function msx(imsg)
	local msg = luaLFS:msx(imsg)
	for fname, func in pairs(func_msx) do
		io.write ("MSX "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_MSX, msx)

function msl(imsg)
	local msg = luaLFS:msl(imsg)
	for fname, func in pairs(func_msl) do
		io.write ("MSL "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_MSL, msl)

function crs(imsg)
	local msg = luaLFS:crs(imsg)
	for fname, func in pairs(func_crs) do
		io.write ("CRS "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_CRS, crs)

function bfn(imsg)
	local msg = luaLFS:bfn(imsg)
	for fname, func in pairs(func_bfn) do
		io.write ("BFN "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_BFN, bfn)

function axi(imsg)
	local msg = luaLFS:axi(imsg)
	for fname, func in pairs(func_axi) do
		io.write ("AXI "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_AXI, axi)

function axo(imsg)
	local msg = luaLFS:axp(imsg)
	for fname, func in pairs(func_axo) do
		io.write ("AXO "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_AXO, axo)

function btn(imsg)
	local msg = luaLFS:btn(imsg)
	for fname, func in pairs(func_btn) do
		io.write ("BTN "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_BTN, btn)

function btc(imsg)
	local msg = luaLFS:btc(imsg)
	for fname, func in pairs(func_btc) do
		io.write ("BTC "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_BTC, btc)

function btt(imsg)
	local msg = luaLFS:btt(imsg)
	for fname, func in pairs(func_btt) do
		io.write ("BTT "..fname)
		local status, error = pcall(func,msg)
		if (error) then err(error) end
		io.write (" done\n")
	end
end
evt_bind(ISP_BTT, btt)
