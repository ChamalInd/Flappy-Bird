Pipe = Class{}

local PIPE_SCROLL = -60


function Pipe:init()
    self.image = love.graphics.newImage('Images/pipe.png')

    self.x = VIRTUAL_WIDTH
    self.y = math.random(VIRTUAL_HEIGHT / 2, VIRTUAL_HEIGHT - 60)

    self.width = self.image:getWidth()
end


function Pipe:update(dt)
    self.x = self.x + (PIPE_SCROLL * dt)
end


function Pipe:render()
    love.graphics.draw(self.image, self.x, self.y)
end