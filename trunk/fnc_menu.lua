function clear_menu()
	for i= 141, 150 do
		luaLFS:bfn(0, 255, i, 0)
	end
end

function draw_button(ucid)
	for i,val in ipairs(buttons) do
		luaLFS:btn(1, ucid, 140+i, 0, 32+8, 0, 0, (140-#buttons*5)+i*10, 50, 10, val)
	end
end
