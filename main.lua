-- defining windows dimensions
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- defining background scrollings
local backgroundScroll = 0
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 413

-- variables for spawning pipes
local pipes = {}
local spawnTimer = 0

-- importing external libraries
push = require('Libraries/push')
Class = require('Libraries/class')

-- importing objects
require('Objects/Bird')
require('Objects/Pipe')


function love.load()
    -- adding filter for a pixelated view 
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- seeding random function 
    math.randomseed(os.time())

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

    -- adding a table to store keyboard memory 
    love.keyboard.keysPressed = {}
end


function love.resize(w, h)
    push:resize(w, h)
end


function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'q' or key == 'escape' then
        love.event.quit()
    end
end


function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end


function love.update(dt)
    -- scrolling the background 
    backgroundScroll = (backgroundScroll + (BACKGROUND_SCROLL_SPEED * dt)) % BACKGROUND_LOOPING_POINT
    groundScroll = (groundScroll + (GROUND_SCROLL_SPEED * dt)) % VIRTUAL_WIDTH

    -- adding pipes every 2 second
    spawnTimer = spawnTimer + dt

    if spawnTimer > 2 then
        table.insert(pipes, Pipe())
        spawnTimer = 0
    end

    bird:update(dt)

    -- moving pipes 
    for k, pipe in pairs(pipes) do
        pipe:update(dt)

        -- remove unnecessory pipes 
        if pipe.x < -pipe.width then
            table.remove(pipe, k)
        end
    end

    -- resetting keyboard memory
    love.keyboard.keysPressed = {}
end


function love.draw()
    push:start()

    -- drawing backgrounds 
    love.graphics.draw(background, -backgroundScroll, 0)
    
    -- drawing bird 
    bird:render()

    -- drawing pipes 
    for k, pipe in pairs(pipes) do
        pipe:render()
    end

    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)  

    push:finish()
end
