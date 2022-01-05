--[[
    GameOverState Class
]]


GameOverState = Class{__includes = BaseState}

TitleState = Class{__includes = BaseState}

function GameOverState:update(dt) 
    if love.keyboard.wasPressed('enter') or
        love.keyboard.wasPressed('return') then
            gStateMachine:change('title')
    end
end

function GameOverState:render() 
    love.graphics.printf('Game over!',
                        0, VIRTUAL_HEIGHT / 2 - 8, 
                        VIRTUAL_WIDTH, 'center')
end