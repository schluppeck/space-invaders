--[[
    space invaders / reworked by ds
    based on https://www.youtube.com/watch?v=jsNqs-QVRxg
    CS50 harvard 
    original resolution: 224 x 256

]]
require "src/Dependencies"

 
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
                VIRTUAL_HEIGHT/2 - 32, SHIP_ID)
end

function love.upload()
end

function love.keypressed(key)

    if key == 'escape' then
        love.event.quit()
    end

end

function love.draw()
    push:start()
    -- fake resolution...
    -- love.graphics.print("Space invaders", 0, VIRTUAL_HEIGHT/2)
    love.graphics.draw(gTextures['aliens'], 
                        gFrames['aliens'][SHIP_ID],
                    100, 100)

    push:finish()
end