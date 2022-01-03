--[[
    space invaders / reworked by ds
    based on https://www.youtube.com/watch?v=jsNqs-QVRxg
    CS50 harvard 
    original resolution: 224 x 256
]]
require "src/Dependencies"

local projectiles = {}
local aliens = {}
local ship  = {}

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Space Invaders')

    gFont =  love.graphics.newFont('font/PressStart2P.ttf',8)
    love.graphics.setFont(gFont)
 
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT,
            WINDOW_WIDTH, WINDOW_HEIGHT, {
                fullscreen = false,
                vsync = true, 
                resizable = true
            })

    ship = Ship(VIRTUAL_WIDTH/2 - ALIEN_SIZE/2,
                VIRTUAL_HEIGHT - 32, SHIP_ID)


    for y = 0,ALIENS_TALL-1 do 
        for x = 0, ALIENS_WIDE-1 do 
            table.insert(aliens, Alien(x * ALIEN_SIZE, y * ALIEN_SIZE, 
            math.random(N_ALIENS)))
        end
    end

    -- extend name space of love.keyboard with a table
    love.keyboard.keysPressed = {}
end

function love.update(dt)
    ship:update(dt, projectiles)

    for _, projectile in pairs(projectiles) do
       projectile:update(dt)
    end 

    love.keyboard.keysPressed = {}
end
 
function love.keypressed(key)
 
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true

end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.draw()
    push:start()
    -- fake resolution...
    -- love.graphics.print("Space invaders", 0, VIRTUAL_HEIGHT/2)
    
    love.graphics.clear(BG_COLOR_R,BG_COLOR_G,BG_COLOR_B,1)

    ship:render()

    -- draw all projectiles
    for _, projectile in pairs(projectiles) do 
        projectile:render()
    end

    -- draw all aliens
    for _, alien in pairs(aliens) do 
        alien:render()
    end


    push:finish()
end