io.stdout:setvbuf("no")

function love.load()
    Object = require "classic"
    
    require "entity"
    require "player"
    require "wall"
    require "box"
    
    player = Player(100,100)
    wall = Wall(200,100)
    box1 = Box(300,200)
end

function love.update(dt)
    player:update(dt)
    wall:update(dt)
    box1:update(dt)
    player:resolveCollision(wall)
    box1:resolveCollision(player)
end

function love.draw()
    player:draw()
    wall:draw()
    box1:draw()
end