-- tell/init.lua

tell = {}

local list = {}

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
