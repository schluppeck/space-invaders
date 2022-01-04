--[[
    constant for space invaders
]]

-- general variables
VIRTUAL_WIDTH = 224
VIRTUAL_HEIGHT = 256

WINDOW_WIDTH = VIRTUAL_WIDTH * 2
WINDOW_HEIGHT = VIRTUAL_HEIGHT * 2

BG_COLOR_R = 20/255
BG_COLOR_G = 10/255
BG_COLOR_B = 30/255

-- alien, ship, projectile sprites
ALIEN_SCALER = 2
ALIEN_SIZE = 12 * ALIEN_SCALER
N_ALIENS = 256

SHIP_ID = 38
SHIP_SIZE = ALIEN_SIZE
SHIP_SPEED = 100

ALIENS_WIDE = 8
ALIENS_TALL = 5
ALIEN_MOVEMENT_INTERVAL = 0.5
ALIEN_STEP_LENGTH = 5
ALIEN_STEP_HEIGHT = 8

ALIEN_FIRE_INTERVAL = 10 -- min/max for randomisation

FAR_RIGHT_ALIEN = ALIENS_WIDE
FAR_LEFT_ALIEN = 1

PROJECTILE_WIDTH = 1
PROJECTILE_LENGTH = 5
PROJECTILE_SPEED = 120

PROJECTILE_COLOR = {1, 0, 0, 0.8}

