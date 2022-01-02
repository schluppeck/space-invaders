--[[
    Entity base class
]]

Entity = Class{}

function Entity:init(x,y,sprite)
  self.x = x
  self.y = y
  self.sprite = sprite   
end