Bird = Class{}

local GRAVITY = 980


function Bird:init()
    self.image = love.graphics.newImage('Images/bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    -- setting bird position to middle of screen 
    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

    -- setting y velocity
    self.dy = 0
end


function Bird:update(dt)
    -- updating y velocity
    self.dy = self.dy + (GRAVITY * dt)

    if love.keyboard.wasPressed('space') then
        self.dy = -300
    end

    -- updating y position 
    self.y = math.max(self.y + (self.dy * dt), 0)

end


function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end