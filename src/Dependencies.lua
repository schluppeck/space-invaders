--[[
    Dependencies
]]
Class = require('lib/class')
push = require('lib/push')

require 'src/Entity'
require 'src/Alien'
require 'src/constants'
require 'src/Projectile'
require 'src/Ship'
require 'src/Util'


gTextures = {
    ['aliens'] = love.graphics.newImage('graphics/aliens12.png')
}

gFrames = {
    ['aliens'] = GenerateQuads(gTextures['aliens'],ALIEN_SIZE,ALIEN_SIZE)
}

gSounds = {
    ['laser'] = love.audio.newSource('sounds/laser.wav', 'static'),
    ['laser_alien'] = love.audio.newSource('sounds/laser_alien_22.wav', 'static'),
    ['explosion'] = love.audio.newSource('sounds/explosion.wav', 'static')
}