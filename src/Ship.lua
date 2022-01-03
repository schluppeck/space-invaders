--[[
    Ship player class
]]

Ship = Class{__includes = Entity}
--x
--y
--sprite (#)


function Ship:update(dt, projectiles)

    if love.keyboard.isDown('left') then
        -- move, but clamp to 0
        self.x = math.max(0,self.x -SHIP_SPEED * dt)
    elseif love.keyboard.isDown('right') then
        -- move, but clamp to VIRTUAL_WIDTH
        self.x = math.min(VIRTUAL_WIDTH-ALIEN_SIZE, self.x +SHIP_SPEED * dt)
    end

    if love.keyboard.wasPressed('space') then
        -- shoot from ship.x, ship.y with vel
        table.insert(projectiles, Projectile(self.x + SHIP_SIZE/2, self.y - PROJECTILE_LENGTH, 'up'))
    end

end