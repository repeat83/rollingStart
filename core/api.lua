-- TYPES : (all multi-byte types are PC style - lowest byte first)
-- ===============================================================
-- char(1)	- A
-- byte(1)	- b
-- word(2)	- H
-- short(2)	- h
-- unsigned(4)	- L
-- int(4)	- l
-- float(4)	- f
-- string	- z

luaLFS.VERSION_API = 0.15

print("Loading API v"..luaLFS.VERSION_API)

-- MISC
function luaLFS:tiny(reqi, subt)
	if (subt) then
		local omsg = bpack("bbbb", 4, ISP_TINY, reqi, subt)
		luaLFS.sendmsg(omsg, string.len(omsg))
	else
		local n, psize, pty, reqi, subt = bunpack(reqi, "bbbbb")
		return {reqi = reqi, subt = subt}
	end
end

function luaLFS:small(reqi, subt, uval)
	if (subt) then
		local omsg = bpack("bbbbL", 8, ISP_SMALL, reqi, subt, uval)
		luaLFS.sendmsg(omsg, string.len(omsg))
	else
		local n, psize, pty, reqi, subt, uval = bunpack(reqi, "bbbbL")
		if (subt == SMALL_VTA) or (subt == SMALL_RTP) then
			return {reqi = reqi, subt = subt, uval = uval}
		else
			return nil
		end
	end

end

-- Strip chars
-- ^L = Latin 1
-- ^G = Greek
-- ^C = Cyrillic
-- ^J = Japanese
-- ^E = Central Europe
-- ^T = Turkish
-- ^B = Baltic
-- ^0-9
function luaLFS:stripctrlchars(imsg)
	return string.gsub(imsg, "%^[%L%G%C%J%E%T%B%d]", "")
end

function luaLFS:ver(imsg)
	local n, psize, pty, reqi, spare, version, product, insimver = bunpack(imsg, "bbbbA8A6H")
	return { reqi = reqi, version = version, product = product, insimver = insimver }
end

-- STATE REPORTING AND REQUESTS
function luaLFS:sta(imsg)
	local n, psize, pty, reqi, zero, replayspeed, flags, ingamecam, viewplid, nump, numconns, numfinished, raceinprog, qualmins, racelaps, spare2, spare3, track, weather, wind = bunpack(imsg, "bbbbfHbbbbbbbbbbA6bb")
	return { reqi = reqi, replayspeed = replayspeed, flags = flags, ingamecam = ingamecam, viewplid = viewplid, nump = nump, numconns = numconns, numfinished = numfinished, raceinprog = raceinprog, qualmins = qualmins, racelaps = racelaps, track = track, weather = weather, wind = wind }
end

-- SCREEN MODE
function luaLFS:mod(sixteenbit, refresh, width, height)
	local omsg = bpack("bbbbllll", 20, ISP_MOD, 0, 0, sixteenbit, refresh, width, height)
	luaLFS.sendmsg(omsg, string.len(omsg))
end

-- TEXT MESSAGES AND KEY PRESSES
function luaLFS:mso(imsg)
	local n, psize, pty, reqi, spare, ucid, plid, user, textstart, msg = bunpack(imsg, "bbbbbbbbz")
	return { reqi = reqi, ucid = ucid, plid = plid, user = user, textstart = textstart, msg = msg }
end

function luaLFS:iii(imsg)
	local n, psize, pty, reqi, spare, ucid, plid, spare2, spare3, msg = bunpack(imsg, "bbbbbbbbz")
	return { reqi = reqi, ucid = ucid, plid = plid, msg = msg}
end

-- MESSAGES IN (TO LFS)
function luaLFS:mst(imsg)
	-- XXX: Add multi-packet support for msgs longer than 63 bytes (last byte is always \0)
	local omsg = bpack("bbbbz", 68, ISP_MST, 0, 0, imsg..string.rep("\0", 63 - string.len(imsg)))
	luaLFS.sendmsg(omsg, string.len(omsg))
end

function luaLFS:msx(imsg)
	local omsg = bpack("bbbbz", 100, ISP_MSX, 0, 0, imsg..string.rep("\0", 95 - string.len(imsg)))
	luaLFS.sendmsg(omsg, string.len(omsg))
end

function luaLFS:msl(sound, imsg)
	local omsg = bpack("bbbbz", 132, ISP_MSL, 0, sound, imsg..string.rep("\0", 127 - string.len(imsg)))
	luaLFS.sendmsg(omsg, string.len(omsg))
end

function luaLFS:mtc(sound, ucid, plid, msg)
	-- XXX: Add multi-packet support for msgs longer than 63 bytes (last byte is always \0)
	local omsg = bpack("bbbbbbbbz", 136, ISP_MTC, 0, sound, ucid, plid, 0, 0, msg..string.rep("\0", 127 - string.len(msg)))
	luaLFS.sendmsg(omsg, string.len(omsg))
end

function luaLFS:sch(char, flags)
	local omsg = bpack("bbbbbbbb", 8, ISP_SCH, 0, 0, string.byte(char), flags, 0, 0)
	luaLFS.sendmsg(omsg, string.len(omsg))
end

-- MULTIPLAYER NOTIFICATION
function luaLFS:ism(imsg)
	local n, psize, pty, reqi, spare, host, spare1, spare2, spare3, hname = bunpack(imsg, "bbbbbbbbz")
	return { reqi = reqi, host = host, hname = hname }
end

-- VOTE NOTIFY AND CANCEL
function luaLFS:vtn(imsg)
	-- UPDATED
	local n, psize, pty, reqi, spare, ucid, action, spare2, spare3 = bunpack(imsg, "bbbbbbbb")
	return { reqi = reqi, ucid = ucid, action = action }
end

function luaLFS:vtc()
--reqi = reqi, ???
	self:tiny(0, TINY_VTC)
end

function luaLFS:vta(imsg)
	-- Vote outcome
	-- Subscribe to a IS_SMALL and it will return non-nil values if it was a completed vote action
	local n, psize, pty, reqi, subt, uval = bunpack(imsg, "bbbbL")
	if (uval == SMALL_VTA) then
		return {reqi = reqi, subt = subt, uval = uval}
	else
		return nil
	end
end

-- RACE TRACKING
function luaLFS:rst(imsg)
	local n, psize, pty, reqi, zero, racelaps, qualmins, nump, spare, track, weather, wind, flags, numnodes, finish, slit1, split2, split3 = bunpack(imsg, "bbbbbbbbA6bbHHHHHH")
	local n, track = bunpack(track, "z")
	return { reqi = reqi, racelaps = racelaps, qualmins = qualmins, nump = nump, track = track, weather = weather, wind = wind, flags = flags, numnodes = numnodes, finish = finish, split1 = slit1, split2 = split2, split3 = split3 }
end

function luaLFS:ncn(imsg)
	local n, psize, pty, reqi, ucid, uname, pname, admin, total, flags, spare3 = bunpack(imsg, "bbbbA24A24bbbb")
	local n, uname = bunpack(uname, "z")
	local n, pname = bunpack(pname, "z")
	return { reqi = reqi, ucid = ucid, uname = uname, pname = pname, admin = admin, total = total, flags = flags}
end

function luaLFS:cnl(imsg)
	local n, psize, pty, reqi, ucid, reason, total, spare2, spare3 = bunpack(imsg, "bbbbbbbb")
	return { reqi = reqi, ucid = ucid, reason = reason, total = total }
end

function luaLFS:cpr(imsg)
	local n, psize, pty, reqi, ucid, pname, plate = bunpack(imsg, "bbbbA24A8")
	local n, pname = bunpack(pname, "z")
	return { reqi = reqi, ucid = ucid, pname = pname, plate = plate }
end

function luaLFS:npl(imsg)
	local n, psize, pty, reqi, plid, ucid, ptype, flags, pname, plate, cname, sname, tyres, h_mass, h_tres, model, pass, spare, sp0, nump, sp2, sp3 = bunpack(imsg, "bbbbbbHA24A8A4A16A4bbbblbbbb")
	local n, pname = bunpack(pname, "z")
	local n, cname = bunpack(cname, "z")
	local n, sname = bunpack(sname, "z")
	return { reqi = reqi, plid = plid, ucid = ucid, ptype = ptype, flags = flags, pname = pname, plate = plate, cname = cname, sname = sname, tyres = tyres, h_mass = h_mass, h_tres = h_tres, model = model, pass = pass, nump = nump }
end

function luaLFS:plp(imsg)
	local n, psize, pty, reqi, plid = bunpack(imsg, "bbbb")
	return { reqi = reqi, plid = plid }
end

function luaLFS:pll(imsg)
	local n, psize, pty, reqi, plid = bunpack(imsg, "bbbb")
	return { reqi = reqi, plid = plid }
end

function luaLFS:crs(imsg)
	local n, psize, pty, reqi, plid = bunpack(imsg, "bbbb")
	return { reqi = reqi, plid = plid }
end

function luaLFS:lap(imsg)
	local n, psize, pty, reqi, plid, ltime, etime, lapsdone, flags, sp0, penalty, numstops, sp3 = bunpack(imsg, "bbbbLLHHbbbb")
	return { reqi = reqi, plid = plid, ltime = ltime, etime = etime, lapsdone = lapsdone, flags = flags, penalty = penalty, numstops = numstops }
end

function luaLFS:spx(imsg)
	local n, psize, pty, reqi, plid, stime, etime, split, penalty, numstops, sp3 = bunpack(imsg, "bbbbLLbbbb")
	return { reqi = reqi, plid = plid, stime = stime, etime = etime, split = split, penalty = penalty, numstops = numstops }
end

function luaLFS:pit(imsg)
	local n, psize, pty, reqi, plid, lapsdone, flags, sp0, penalty, numstops, sp3, tyres, work, spare = bunpack(imsg, "bbbbHHbbbbb4LL")
	return { reqi = reqi, plid = plid, lapsdone = lapsdone, flags = flags, penalty = penalty, numstops == numstops, tyres = tyres, work = work }
end

function luaLFS:psf(imsg)
	local n, psize, pty, reqi, plid, stime, spare = bunpack(imsg, "bbbbLL")
	return { reqi = reqi, reqi = reqi, plid = plid, stime = stime }
end

function luaLFS:pla(imsg)
	local n, psize, pty, reqi, plid, fact, sp1, sp2, sp3 = bunpack(imsg, "bbbbbbbb")
	return { reqi = reqi, plid = plid, fact = fact }
end

function luaLFS:cch(imsg)
	local n, psize, pty, reqi, plid, camera, sp1, sp2, sp3 = bunpack(imsg, "bbbbbbbb")
	return { reqi = reqi, plid = plid, camera = camera }
end

function luaLFS:pen(imsg)
	local n, psize, pty, reqi, plid, oldpen, newpen, reason, sp3 = bunpack(imsg, "bbbbbbbb")
	return { reqi = reqi, plid = plid, oldpen = oldpen, newpen = newpen, reason = reason }
end

function luaLFS:toc(imsg)
	local n, psize, pty, reqi, plid, olducid, newucid, sp2, sp3 = bunpack(imsg, "bbbbbbbb")
	return { reqi = reqi, plid = plid, olducid = olducid, newucid = newucid }
end

function luaLFS:flg(imsg)
	local n, psize, pty, reqi, plid, offon, flag, carbehind, sp3 = bunpack(imsg, "bbbbbbbb")
	return { reqi = reqi, plid = plid, offon = offon, flag = flag, carbehind = carbehind }
end

function luaLFS:pfl(imsg)
	local n, psize, pty, reqi, plid, flags, spare = bunpack(imsg, "bbbbHH")
	return { reqi = reqi, plid = plid, flags = flags }
end

function luaLFS:fin(imsg)
	local n, psize, pty, reqi, plid, ttime, btime, spa, numstops, confirm, spb, lapsdone, flags = bunpack(imsg, "bbbbLLbbbbHH")
	return { reqi = reqi, plid = plid, ttime = ttime, btime = btime, numstops = numstops, confirm = confirm, lapsdone = lapsdone, flags = flags }
end

function luaLFS:res(imsg)
	local n, psize, pty, reqi, plid, uname, pname, plate, cname, ttime, btime, spa, numstops, confirm, spb, lapsdone, flags, resultnum, numres, pseconds = bunpack(imsg, "bbbbA24A24A8A4LLbbbbHHbbH")
	local n, uname = bunpack(uname, "z")
	local n, pname = bunpack(pname, "z")
	local n, cname = bunpack(cname, "z")
	return { reqi = reqi, plid = plid, uname = uname, pname = pname, plate = plate, cname = cname, ttime = ttime, btime = btime, numstops = numstops, confirm = confirm, lapsdone = lapsdone, flags = flags, resultnum = resultnum, numres = numres, pseconds = pseconds }
end

function luaLFS:reo(...)
	if (#arg == 1) then
		-- Receiving IS_REO
		local n, psize, pty, reqi, nump, plid_ = bunpack(arg[1], "bbbbA32")
		local plid = {}
		for i=1,32 do plid[i] = plid_:byte(i) end
		return { reqi = reqi, nump = nump, plid = plid }
	elseif (#arg == 3) then
		-- Sending IS_REO
		-- To use: luaLFS:reo(reqi, nump, tableofplid)
		local plids="", i
		for i = 1, arg[2] do
			plids = plids..bpack("b", arg[3][i])
		end
--		local omsg = bpack("bbbbA32", 36, ISP_REO, arg[1], arg[2], plids)
		local omsg = bpack("bbbb", 36, ISP_REO, arg[1], arg[2])..plids
		luaLFS.sendmsg(omsg, string.len(omsg))
	else
		error("Invalid arguments")
	end
end

-- AUTOX
function luaLFS:axi(imsg)
	local n, psize, pty, reqi, zero, axstart, numcp, numo, lname = bunpack(imsg, "bbbbbbHA32")
	local n, lname = bunpack(lname, "z")
	return { reqi = reqi, axstart = axstart, numcp = numcp, numo = numo, lname = lname }
end

function luaLFS:axo(imsg)
	local n, psize, pty, reqi, plid = bunpack(imsg, "bbbb")
	return { reqi = reqi, plid = plid }
end

-- CAR TRACKING PACKETS
function luaLFS:nlp(imsg)
	local n, psize, pty, reqi, nump = bunpack(imsg, "bbbb")
	local q, nodelaparr = bunpack(imsg, "A"..6*nump, n)
	local nodelap = { }

	local i, s
	s = 1
	for i = 1, nump do
		local node, lap, plid, position 
		s, node, lap, plid, position = bunpack(nodelaparr, "HHbb", s)
		nodelap[plid] = { node = node, lap = lap, position = position }
	end
	return { reqi = reqi, nump = nump, nodelap = nodelap }
end

function luaLFS:mci(imsg)
	local n, psize, pty, reqi, numc = bunpack(imsg, "bbbb")
	local q, compcararr = bunpack(imsg, "A"..28*numc, n)
	local compcar = { }

	local i, s
	s = 1
	for i = 1, numc do
		local node, lap, plid, position, info, sp3, x, y, z, speed, direction, heading, angvel 
		s, node, lap, plid, position, info, sp3, x, y, z, speed, direction, heading, angvel = bunpack(compcararr, "HHbbbblllHHHh", s)
		compcar[plid] = { node = node, lap = lap, position = position, info = info, x = x, y = y, z = z, speed = speed, direction = direction, heading = heading, angvel = angvel }
	end
	return { reqi = reqi, numc = numc, compcar = compcar }
end


-- CAMERA CONTROL
function luaLFS:cpp(...)
	if (#arg == 1) then
		local n, psize, pty, reqi, zero, x, y, z, h, p, r, viewplid, ingamecam, fov, time, flags = bunpack(arg[1], "bbbblllHHHbbfHH")
		return { reqi = reqi, x = x, y = y, z = z, h = h, p = p, r = r, viewplid = viewplid, ingamecam = ingamecam, fov = fov, time = time, flags = flags }
	elseif (#arg == 12) then
		-- reqi, posx, posy, posz, heading, pitch, roll, viewplid, ingamecam, fov, time, flags
		local omsg = bpack("bbbblllHHHbbfHH", 32, ISP_CCP, arg[1], 0, arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], arg[8], arg[9], arg[10], arg[11], arg[12])
		luaLFS.sendmsg(omsg, string.len(omsg))
	end
end

function luaLFS:scc(viewid, ingamecam)
    local omsg = bpack("bbbbbbbb", 8, ISP_SCC, 0, 0, viewid, ingamecam, 0, 0)
    luaLFS.sendmsg(omsg, string.len(omsg))
end

-- BUTTONS
function luaLFS:bfn(...)
    if(#arg == 1) then
        local imsg = arg[1]
        local n, psize, pty, reqi, subt, ucid, clickid, inst, sp3 = bunpack(imsg, "bbbbbbbb")
        return {reqi = reqi, subt = subt, ucid = ucid, clickid = clickid, inst = inst}
    elseif(#arg == 4) then
        local subt, ucid, clickid, inst = arg[1], arg[2], arg[3], arg[4]
        local omsg = bpack("bbbbbbbb", 8, ISP_BFN, 0, subt, ucid, clickid, inst, 0)
        luaLFS.sendmsg(omsg, string.len(omsg))
    end
end


function luaLFS:btn(reqi, ucid, clickid, inst, bstyle, typein, l, t, w, h, imsg)
	local imsg = imsg..string.rep("\0", 239 - string.len(imsg))
	local omsg = bpack("bbbbbbbbbbbbz", 12 + string.len(imsg)+1, ISP_BTN, reqi, ucid, clickid, inst, bstyle, typein, l, t, w, h, imsg)
	luaLFS.sendmsg(omsg, string.len(omsg))
end

function luaLFS:btc(imsg)
	local n, psize, pty, reqi, ucid, clickid, inst, cflags, sp3 = bunpack(imsg, "bbbbbbbb")
	return { reqi = reqi, ucid = ucid, clickid = clickid, inst = inst, cflags = cflags }
end

function luaLFS:btt(imsg)
	local n, psize, pty, reqi, ucid, clickid, inst, typein, sp3, text = bunpack(imsg, "bbbbbbbbA96")
	return { reqi = reqi, ucid = ucid, clickid = clickid, inst = inst, typein = typein, text = text }
end
