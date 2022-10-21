local function sign(x)
	if x <= 0 then
		return -1
	else
		return 1
	end
end

core.register_chatcommand("area",{
  description = "Assisted area protection",
  params = "<X,Y,Z>",
  func = function(param)
	local size = core.string_to_pos(param)
	if not size then
		return false, "Invalid size"
	end
	local pos1 = vector.round(core.localplayer:get_pos())
	local look_dir = core.camera:get_look_dir()
	local dir = vector.apply(look_dir, sign)
	local pos2 = {x=pos1.x+(size.x*dir.x), y=pos1.y+(size.y*dir.y), z=pos1.z+(size.z*dir.z)}
	core.run_server_chatcommand("area_pos1",core.pos_to_string(pos1):gsub("[%(%)]",""))
	core.run_server_chatcommand("area_pos2",core.pos_to_string(pos2):gsub("[%(%)]",""))
	local wp1 = core.localplayer:hud_add({
		hud_elem_type = "waypoint",
		name = "pos1",
		number = 0xFF0000,
		world_pos = pos1})
	local wp2 = core.localplayer:hud_add({
		hud_elem_type = "waypoint",
		name = "pos2",
		number = 0xFF0000,
		world_pos = pos2})
	core.after(10,function()
		if wp1 and wp2 then
			core.localplayer:hud_remove(wp1)
			core.localplayer:hud_remove(wp2)
		end
	end)
end})

core.register_chatcommand("area-around",{
  description = "Assisted area protection (center = playerpos)",
  params = "<X,Y,Z>",
  func = function(param)
	local size = core.string_to_pos(param)
	if not size then
		return false, "Invalid size"
	end
	local ppos = vector.round(core.localplayer:get_pos())
	local pos1 = vector.round({x=ppos.x-size.x/2, y=ppos.y-size.y/2, z=ppos.z-size.z/2})
	local pos2 = vector.round({x=ppos.x+size.x/2, y=ppos.y+size.y/2, z=ppos.z+size.z/2})
	core.run_server_chatcommand("area_pos1",core.pos_to_string(pos1):gsub("[%(%)]",""))
	core.run_server_chatcommand("area_pos2",core.pos_to_string(pos2):gsub("[%(%)]",""))
	local wp1 = core.localplayer:hud_add({
		hud_elem_type = "waypoint",
		name = "pos1",
		number = 0xFF0000,
		world_pos = pos1})
	local wp2 = core.localplayer:hud_add({
		hud_elem_type = "waypoint",
		name = "pos2",
		number = 0xFF0000,
		world_pos = pos2})
	core.after(10,function()
		if wp1 and wp2 then
			core.localplayer:hud_remove(wp1)
			core.localplayer:hud_remove(wp2)
		end
	end)
end})
