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
    
    objects = {}
    
    table.insert(objects,player)
    table.insert(objects,wall)
    table.insert(objects,box1)
end

function love.update(dt)
    
    for i,v in ipairs (objects) do
        v:update(dt)
        for j,k in ipairs (objects) do
            if v ~= k then
               v:resolveCollision(k) 
            end
        end
    end
end

function love.draw()
    player:draw()
    wall:draw()
    box1:draw()
end