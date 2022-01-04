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
local alienDirection = 'right' -- or left, down
local alienMovementTimer = 0

function love.load()
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
    ship.canFire = true -- make sure ship can fire

    for y = 0, ALIENS_TALL-1 do 
        for x = 0, ALIENS_WIDE-1 do 
            local alien = Alien(x * ALIEN_SIZE, y * ALIEN_SIZE, 
            math.random(N_ALIENS))
            
            if y == ALIENS_TALL-1 then
                alien.canFire = true
                alien.fireTimer = 0
                alien.fireInterval = math.random(ALIEN_FIRE_INTERVAL)
            end

            table.insert(aliens, alien)
        end
    end

    -- extend name space of love.keyboard with a table
    love.keyboard.keysPressed = {}
end

function love.update(dt)
    ship:update(dt, projectiles)


    for p_key, projectile in pairs(projectiles) do
        projectile:update(dt)

        -- if projectiles go off screen, remove
        -- otherwise check if collision w/ alien.
        if projectile.y < -PROJECTILE_LENGTH then 
            projectiles[p_key] = nil
        else
            for a_key,alien in pairs(aliens) do 
                if projectile:collides(alien) and not alien.invisible then
                    projectiles[p_key] = nil
                    gSounds['explosion']:stop()
                    gSounds['explosion']:play()
                    alien.invisible = true
                end
            end
        end
    end

    -- move aliens
    tickAliens(dt)

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

    love.graphics.print("#projectiles: " .. tostring(#projectiles))

    -- draw all projectiles
    for _, projectile in pairs(projectiles) do 
        projectile:render()
    end

    -- draw all aliens
    for _, alien in pairs(aliens) do 
        alien:render()
    end

    ship:render()
    push:finish()
end

-- logic for making aliens move down...
function tickAliens(dt)
    
    for _, alien in pairs(aliens) do
        if not alien.invisible then
            if alien.canFire then
                alien.fireTimer = alien.fireTimer + dt

                if alien.fireTimer >= alien.fireInterval then
                    alien.fireTimer = alien.fireTimer - alien.fireInterval
                    alien.fireInterval = math.random(ALIEN_FIRE_INTERVAL)
                    
                    gSounds['laser_alien']:stop()
                    gSounds['laser_alien']:play()
                    
                    
                    table.insert(projectiles,
                                Projectile(
                                    alien.x, 
                                    alien.y + alien.height + ALIEN_STEP_HEIGHT,
                                    'down'))
                end
            end
        end
    end


    alienMovementTimer = alienMovementTimer + dt

    if alienMovementTimer >= ALIEN_MOVEMENT_INTERVAL then
        if alienDirection == 'right' then
            if aliens[FAR_RIGHT_ALIEN].x >= VIRTUAL_WIDTH - ALIEN_SIZE  then
                alienDirection = 'left'
            
                for _, alien in pairs(aliens) do 
                    alien.y = alien.y + ALIEN_STEP_HEIGHT
                end
            else

                for _, alien in pairs(aliens) do 
                    alien.x = alien.x + ALIEN_STEP_LENGTH
                end

            end
        else
            if aliens[FAR_LEFT_ALIEN].x <= 0  then
                alienDirection = 'right'
            
                for _, alien in pairs(aliens) do 
                    alien.y = alien.y + ALIEN_STEP_HEIGHT
                end
            else
                for _, alien in pairs(aliens) do 
                    alien.x = alien.x - ALIEN_STEP_LENGTH
                end
            end    
        end
        alienMovementTimer = alienMovementTimer - ALIEN_MOVEMENT_INTERVAL
    end
end