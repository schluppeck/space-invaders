--[[
    Projectile
]]

Projectile = Class{}

function Projectile:init(x, y, direction)
    self.x = x
    self.y = y
    self.direction = direction
end

function Projectile:update(dt)
    if self.direction == 'up' then
        self.y = self.y - PROJECTILE_SPEED * dt
    else
        self.y = self.y + PROJECTILE_SPEED * dt
    end 
end

function Projectile:render()
    --- make red
    love.graphics.setColor(unpack(PROJECTILE_COLOR))
    love.graphics.rectangle('fill', self.x, self.y, PROJECTILE_WIDTH, PROJECTILE_LENGTH ) -- PROJECTILE_LENGTH)
    -- back to white
    love.graphics.setColor(1,1,1,1)

end
