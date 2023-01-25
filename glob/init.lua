glob = {}

-- Design from https://git.bananach.space/advtrains.git/tree/advtrains/atc.lua
local matchptn = {
	-- func arg: matched group if any
	-- func return: two args, 1) things to append 2) length
	{"%*",function()
		return ".*", 1
	end},
	{"%?",function() return ".", 1 end},
	{"%[(.+)%]",function(match)
		-- we cannot make the [!***] as Lua does not allow reverse match
		return "[" .. match .. "]", #match + 2
	end},
	{"(.)",function(match)
		for _,v in ipairs({"(",")","%",".","+","-","*","[","?","^","$"}) do -- Check escape
			if match == v then return "%" .. match, 1 end
		end
		return match, 1
	end}, -- Final fallback...
}
local function compileloop(globptn)
	local luaptn = ""
	for i, v in pairs(matchptn) do
		local pattern, func = v[1], v[2]
		local match = string.match(globptn, "^"..pattern)
		if match then
			local luaptnappend, length = func(match)
			luaptn = luaptn .. luaptnappend
			globptn = string.sub(globptn,length + 1)
			if globptn ~= "" then
				luaptn = luaptn .. compileloop(globptn)
			end
			return luaptn
		end
	end
	return ""
end
function glob.compile(globptn)
	return "^" .. compileloop(globptn) .. "$"
end

function glob.match_in_list(list,globptn)
	local r = {}
	local luaptn = glob.compile(globptn)
	for i,v in ipairs(list) do
		if string.match(v,luaptn) then
			table.insert(r,v)
		end
	end
	return r
end

local playerlist = {}
local function regen_playerlist()
	local dummy = {}
	for i,v in ipairs(minetest.get_connected_players()) do
		table.insert(dummy,v:get_player_name())
	end
	playerlist = dummy
end
minetest.register_on_joinplayer(regen_playerlist)
minetest.register_on_leaveplayer(regen_playerlist)
regen_playerlist()

function glob.match_players(globptn)
	return glob.match_in_list(playerlist,globptn)
end
