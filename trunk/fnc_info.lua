function info(imsg,y,pause)

	local tf = string.char(149)
	local tf_black = "^0"..string.char(149)
	local tf_red = "^1"..string.char(149)
	local tf_green = "^2"..string.char(149)

	if (id == 4) then
		luaLFS:bfn(0, 255, 8, 0)

		local time = 1000
		timer.register(time,function()
			luaLFS:mst("/rcm "..tf_black..tf..tf..tf..tf..tf)
			luaLFS:mst("/rcm_all")
			luaLFS:mst("/say "..tf_black..tf..tf..tf..tf..tf)
			luaLFS:mtc(2,255,0," ") --sound
		end)

		time = time + 7000
		timer.register(time,function()
			luaLFS:mst("/rcm "..tf_red..tf_black..tf..tf..tf..tf_red)
			luaLFS:mst("/rcm_all")
			luaLFS:mst("/say "..tf_red..tf_black..tf..tf..tf..tf_red)
			luaLFS:mtc(4,255,0," ") --sound
		end)

		time = time + 1500
		timer.register(time,function()
			luaLFS:mst("/rcm "..tf_red..tf..tf_black..tf..tf_red..tf)
			luaLFS:mst("/rcm_all ")
			luaLFS:mst("/say "..tf_red..tf..tf_black..tf..tf_red..tf)
			luaLFS:mtc(4,255,0," ") --sound
		end)

		time = time + 1500
		timer.register(time,function()
id = -2
			luaLFS:mst("/rcm "..tf_red..tf..tf..tf..tf..tf)
			luaLFS:mst("/rcm_all")
			luaLFS:mst("/say "..tf_red..tf..tf..tf..tf..tf)
			luaLFS:mtc(4,255,0," ") --sound
		end)

		math.randomseed(os.time())
		time = time + 2000+math.random()*3000
		timer.register(time,function()
--			luaLFS:mst("/rcm ^2^C-=«≈À≈Õ€… ‘À¿√=-")
			luaLFS:mst("/rcm "..buttons[4])
			luaLFS:mst("/rcm_all")
			luaLFS:mst("/say "..tf_green..tf..tf..tf..tf..tf)
			luaLFS:mtc(1,255,0," ") --sound
id = -1
		end)

		time = time + 5000
		timer.register(time,function()
			luaLFS:mst("/rcc_all")
		end)

	else
		luaLFS:btn(8, 255, 8, 0, 32+5, 0, 0, y, 200, 15, imsg) 
		if (pause) then
			timer.register(pause,function()
				luaLFS:bfn(0, 255, 8, 0)
			end)
		end
	end
end

function info_clear()
	luaLFS:bfn(0, 255, 8, 0)
end
