print "Loading Events"

evts = { }

function evt_fire(event, arg)
	local i = 0
	if (evts == nil) then
		evts = { }
		return
	end

	if (evts[event] == nil) then
		return
	end

	for i=1,table.maxn(evts[event]) do
		if (type(evts[event][i]) == "function") then
			pcall(evts[event][i], arg)
		end
	end
end

function evt_bind(event, func)
	if (evts == nil) then
		evts = { }
	end

	if (event == nil) then
	   print("Event is nil")
	   return
	end

	if (func == nil) then
	   print("Func is nill")
	   return
	end

	if (evts[event] == nil) then
	   evts[event] = { }
	end

	if ((not (type(func) == "string")) and (not (type(func) == "function"))) then
		print("Func is invalid type " .. type(func))
		return
	end

	table.insert(evts[event], func)
end

function evt_unbind_all(event)
	if (event == nil) then
	   print("Unbinding all")
	   evts = nil
	   return
	end

	if (evts[event] == nil) then
	   error("No such event")
	   return
	end

	evts[event] = nil
end

function evt_unbind(event, func)
	if (evts == nil) then
		return
	end

	local i = 0
	local n = 0

	if (event == nil) then
	   print("Event is nil")
	   return
	end

	if (func == nil) then
	   print("Func is nil")
		return
	end

	if ((not (type(func) == "function")) and (not (type(func) == "string"))) then
   		print("Func is invalid type " .. type(func))
   		return
	end

	if (evts[event] == nil) then
	   print("No such event " .. event)
	   return
	end

	local sz = table.maxn(evts[event])

	for i=1, sz do
		if (evts[event][i] == nil) then
		   break
		end

		if (evts[event][i] == func) then
			table.remove(evts[event], i)
			n = n + 1
	        i = i - 1
		end
	end

	if (n == sz) then
	   evts[event] = nil
	end

	return
end

evt_bind(EVT_CLEAR_BINDS, evt_unbind_all)
