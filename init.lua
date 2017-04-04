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
