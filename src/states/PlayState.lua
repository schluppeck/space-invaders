--[[
    PlayState
]]

PlayState = Class{__includes = BaseState}


function PlayState:init()
    self.projectiles = {}
    self.aliens = {}
    self.alienDirection   = 'right' -- or left, down
    self.alienMovementTimer = 0

    -- ships and aliens
    self.ship = Ship(VIRTUAL_WIDTH/2 - ALIEN_SIZE/2,
                VIRTUAL_HEIGHT - 32, SHIP_ID)
    self.ship.canFire = true -- make sure ship can fire

    for y = 0, ALIENS_TALL-1 do 
        for x = 0, ALIENS_WIDE-1 do 
            local alien = Alien(x * ALIEN_SIZE, y * ALIEN_SIZE, 
            math.random(N_ALIENS))
            
            if y == ALIENS_TALL-1 then
                alien.canFire = true
                alien.fireTimer = 0
                alien.fireInterval = math.random(ALIEN_FIRE_INTERVAL)
            end

            table.insert(self.aliens, alien)
        end
    end

end 

function PlayState:update(dt)

    self.ship:update(dt, self.projectiles)


    for p_key, projectile in pairs(self.projectiles) do
        projectile:update(dt)

        -- if self.projectiles go off screen, remove
        -- otherwise check if collision w/ alien.
        if projectile.y < -PROJECTILE_LENGTH or 
            projectile.y > VIRTUAL_HEIGHT then 
            self.projectiles[p_key] = nil
        else
            for a_key,alien in pairs(self.aliens) do 
                if projectile:collides(alien) and not alien.invisible then
                    self.projectiles[p_key] = nil
                    gSounds['explosion']:stop()
                    gSounds['explosion']:play()
                    alien.invisible = true
                end
            end

            if projectile:collides(self.ship) and 
               not self.ship.invisible then
                self.ship.invisible = true
                gSounds['explosion_ship']:stop()
                gSounds['explosion_ship']:play()
                gStateMachine:change('game-over')
            end

        end
    end

    -- move aliens
    self:tickAliens(dt)

    love.keyboard.keysPressed = {}

end

function PlayState:render()
    
    love.graphics.clear(BG_COLOR_R,BG_COLOR_G,BG_COLOR_B,1)

    love.graphics.print("#projectiles: " .. tostring(#self.projectiles))

    -- draw all projectiles
    for _, projectile in pairs(self.projectiles) do 
        projectile:render()
    end

    -- draw all aliens
    for _, alien in pairs(self.aliens) do 
        alien:render()
    end

    self.ship:render()
end

-- logic for making aliens move down...
function PlayState:tickAliens(dt)
    
    for _, alien in pairs(self.aliens) do
        if not alien.invisible then
            if alien.canFire then
                alien.fireTimer = alien.fireTimer + dt

                if alien.fireTimer >= alien.fireInterval then
                    alien.fireTimer = alien.fireTimer - alien.fireInterval
                    alien.fireInterval = math.random(ALIEN_FIRE_INTERVAL)
                    
                    gSounds['laser_alien']:stop()
                    gSounds['laser_alien']:play()
                    
                    
                    table.insert(self.projectiles,
                                Projectile(
                                    alien.x, 
                                    alien.y + alien.height + ALIEN_STEP_HEIGHT,
                                    'down'))
                end
            end
        end
    end


    self.alienMovementTimer = self.alienMovementTimer + dt

    if self.alienMovementTimer >= ALIEN_MOVEMENT_INTERVAL then
        if self.alienDirection == 'right' then
            if self.aliens[FAR_RIGHT_ALIEN].x >= VIRTUAL_WIDTH - ALIEN_SIZE  then
                self.alienDirection = 'left'
            
                for _, alien in pairs(self.aliens) do 
                    alien.y = alien.y + ALIEN_STEP_HEIGHT
                end
            else

                for _, alien in pairs(self.aliens) do 
                    alien.x = alien.x + ALIEN_STEP_LENGTH
                end

            end
        else
            if self.aliens[FAR_LEFT_ALIEN].x <= 0  then
                self.alienDirection = 'right'
            
                for _, alien in pairs(self.aliens) do 
                    alien.y = alien.y + ALIEN_STEP_HEIGHT
                end
            else
                for _, alien in pairs(self.aliens) do 
                    alien.x = alien.x - ALIEN_STEP_LENGTH
                end
            end    
        end
        self.alienMovementTimer = self.alienMovementTimer - ALIEN_MOVEMENT_INTERVAL
    end
end


