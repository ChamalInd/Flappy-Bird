-- defining windows dimensions
local WINDOW_WIDTH = 1280
local WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- defining background scrollings
local backgroundScroll = 0
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 413

-- importing external libraries
push = require('Libraries/push')
Class = require('Libraries/class')

-- importing objects
require('Objects/Bird')


function love.load()
    -- adding filter for a pixelated view 
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- setting images 
    background = love.graphics.newImage('Images/background.png')
    ground = love.graphics.newImage('Images/ground.png')

    -- setting Bird
    bird = Bird()

    -- setting window 
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, 
        {
            resizable = true,
            fullscreen = false,
            vsync = true
        }
    )

    -- setting window title 
    love.window.setTitle('Flappy Bird')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, { upscale = 'normal' })
end


function love.resize(w, h)
    push:resize(w, h)
end


function love.keypressed(key)
    if key == 'q' or key == 'escape' then
        love.event.quit()
    end
end


function love.update(dt)
    backgroundScroll = (backgroundScroll + (BACKGROUND_SCROLL_SPEED * dt)) % BACKGROUND_LOOPING_POINT
    groundScroll = (groundScroll + (GROUND_SCROLL_SPEED * dt)) % VIRTUAL_WIDTH
end


function love.draw()
    push:start()

    -- drawing backgrounds 
    love.graphics.draw(background, -backgroundScroll, 0)
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)  
    
    -- drawing bird 
    bird:render()

    push:finish()
end
