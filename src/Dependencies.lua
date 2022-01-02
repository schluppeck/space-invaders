--[[
    Dependencies
]]
Class = require('lib/class')
push = require('lib/push')

require 'src/Alien'
require 'src/constants'
require 'src/Entity'
require 'src/Ship'
require 'src/Util'


gTextures = {
    ['aliens'] = love.graphics.newImage('graphics/aliens12.png')
}

gFrames = {
    ['aliens'] = GenerateQuads(gTextures['aliens'],ALIEN_SIZE,ALIEN_SIZE)
}