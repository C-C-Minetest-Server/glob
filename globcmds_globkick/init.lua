local S = minetest.get_translator("globcmds_globkick")

minetest.register_chatcommand("globkick",{
	description = S("Select players by glob patterns and then kick them"),
	privs = minetest.registered_chatcommands["kick"].privs,
	param = S("<glob pattern> [<reason>]"),
	func = function(name,param)
		local globptn, reason = param:match("([^ ]+) (.+)")
		globptn = globptn or param
		local matches = glob.match_players(globptn)
		if #matches == 0 then
			return false, S("No matches.")
		else
			for i,tokick in ipairs(matches) do
				if not minetest.kick_player(v, reason) then
					minetest.chat_send_player(name,S("Failed to kick @1.",tokick))
				else
					minetest.chat_send_player(name,minetest.translate("__builtin","Kicked @1.",tokick))
					local log_reason = ""
					if reason then
						log_reason = " with reason \"" .. reason .. "\""
					end
					minetest.log("action", name .. " kicks " .. tokick .. log_reason)
				end
			end
			return true, S("Done.")
		end
	end
})
