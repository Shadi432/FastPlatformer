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
    box2 = Box(300,250)
    
    objects = {}
    
    table.insert(objects,player)
    table.insert(objects,wall)
    table.insert(objects,box1)
    table.insert(objects,box2)
end

function love.update(dt)
    local loop = true
    local limit = 0
    
    
    for i,v in ipairs (objects) do
        v:update(dt)
    end
    
    
    while loop do
        loop = false
       
        limit = limit + 1
        if limit > 100 then
            break
        end
        
        for i=1,#objects-1 do
            for j=i+1,#objects do
                local collision = objects[i]:resolveCollision(objects[j])
                
                if collision then
                    loop = true
                end
            end
        end
    end
end

function love.draw()
    for i,v in ipairs (objects) do
        v:draw()
    end
end