--[[
    BaseState 
    every other state inherits from this.
]]

BaseState = Class{}

function BaseState:init() end
function BaseState:update(dt) end
function BaseState:render() end
function BaseState:enter(params) end
function BaseState:exit() end