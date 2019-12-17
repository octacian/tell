-- tell/init.lua

tell = {}

local list = {}

-- Choose command name
local commandname = "tell"
if minetest.get_modpath("mesecons_commandblock") then
  commandname = "tellafk"
end

-- [local function] Load
local function load()
  local res = io.open(minetest.get_worldpath().."/tell.txt", "r")
  if res then
    res = minetest.deserialize(res:read("*all"))
    if type(res) == "table" then
      list = res
    end
  end
end

-- [local function] Save
local function save()
  io.open(minetest.get_worldpath().."/tell.txt", "w"):write(minetest.serialize(list))
end

-- Load
load()

-- [register] On shutdown
minetest.register_on_shutdown(save)

-- [function] Add item
function tell.add(name, from, msg)
  if not list[name] then
    list[name] = {}
  end

  list[name][#list[name] + 1] = {
    from = from,
    msg  = msg,
    time = os.date("%I:%M %p on %B %d, %Y"),
  }

  minetest.log("action", dump(list))

  return #list[name] + 1
end

-- [function] Remove item
function tell.remove(name, id)
  if list[name] and list[name][id] then
    list[name][id] = nil
  end
end

-- [function] Show messages
function tell.show(name)
  if list and list[name] then
    for _, i in ipairs(list[name]) do
      minetest.chat_send_player(name, minetest.colorize("#ff5400", "Message from "
        ..i.from.." at "..i.time..": "..i.msg))

      -- Remove entry
      tell.remove(name, _)
    end
  end
end

-- [register] Chatcommand
minetest.register_chatcommand(commandname, {
  description = "Send a message to an offline or AFK player",
  params = "<name> <message>",
  func = function(name, param)
    local sendto, msg = param:match("^(%S+)%s(.+)$")
    if not sendto or not msg then
      return false, "Invalid usage, see /help " .. commandname .. "."
    end
    minetest.log("action", "Tell from " .. name .. " to " .. sendto
        .. ": " .. msg)

    if tell.add(sendto, name, msg) then
      return true, "I'll pass that on when "..sendto.." is around."
    else
      return false, "Unknown error."
    end
  end,
})

-- [register] On join player
minetest.register_on_joinplayer(function(player)
  local name = player:get_player_name()
  tell.show(name)
end)

-- [register] On chat message
minetest.register_on_chat_message(function(name)
  tell.show(name)
end)
