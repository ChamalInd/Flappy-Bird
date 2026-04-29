-- defining windows dimensions
local WINDOW_WIDTH = 1280
local WINDOW_HEIGHT = 720

local VIRTUAL_WIDTH = 512
local VIRTUAL_HEIGHT = 288

-- importing external libraries
push = require('Libraries/push')
Class = require('Libraries/class')


function love.load()
    -- adding filter for a pixelated view 
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- setting images 
    background = love.graphics.newImage('Images/background.png')
    ground = love.graphics.newImage('Images/ground.png')

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


function love.draw()
    push:start()

    -- drawing backgrounds 
    love.graphics.draw(background, 0, 0)
    love.graphics.draw(ground, 0, VIRTUAL_HEIGHT - 16)    

    push:finish()
end
