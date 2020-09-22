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
    end
    
    for i=1, #objects-1 do
        for j =i+1, #objects do
            objects[i]:resolveCollision(objects[j])
        end
    end
end

function love.draw()
    for i,v in ipairs (objects) do
        v:draw()
    end
end