print "Loading Timer module"

function future()
    local events = {}
    local event =
        function(msec, callback)
            local cb = callback
            local to = luaLFS:mstime()+msec
            return
                function()
                    if luaLFS:mstime() >= to then
                        cb()
                        return true
                    else
                        return false
                    end
                end
        end

    return {
        register =
            function(msec, callback)
                table.insert(events,event(msec,callback))
            end,
        check =
            function()
                local res
                for k,v in pairs(events) do
                    res = v()
                    if res then
                        table.remove(events,k)
                    end
                end
            end
    }
end

timer = future()

--функция для потока проверки таймера
func_thread.timerCheck = function ()
	while true do
--		print("Timer Check")
		timer.check()
		coroutine.yield()
	end
end