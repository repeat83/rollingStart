function conf_serv()
	luaLFS:mst("/msg Configure server start")
	luaLFS:mst("/end")

	timer.register(5000,function()
		luaLFS:mst("/track=BL2r")
		luaLFS:mst("/laps=13")
		luaLFS:mst("/mustpit=yes")
		luaLFS:mst("/vote=no")
		luaLFS:mst("/midrace=no")
		luaLFS:mst("/canreset=no")
		luaLFS:mst("/pass=TEST_EGTR")
		luaLFS:mst("/msg Configure server end")

	end)
end