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
    
    objects = {} -- Needed so we update them all as a group and not have to update/draw objects individually, since they all have their own draw/update methods
    walls = {} -- Needed for walls because they don't need to check collision with themselves, only other objects
    
    table.insert(objects,player)
    table.insert(objects,wall)
    table.insert(objects,box1)
    table.insert(objects,box2)
    
       map = {
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1},
        {1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
    } -- Tilemap
    
    for i,v in ipairs(map) do -- Builds the tilemap
        for j,w in ipairs(v) do
            if w == 1 then
               table.insert(walls,Wall((j-1)*50, (i-1)*50)) 
            end
        end
    end
end

function love.update(dt)
    local loop = true -- Needed for collision detection
    local limit = 0 -- For setting a loop limit so if a collision error happens, the program doesn't get trapped in an infinite loop
    
    
    for i,v in ipairs (objects) do -- Update all objects in objects list
        v:update(dt)
    end
    
    for i,v in ipairs (walls) do -- Because of separate arrays, need to update them separately
       v:update(dt) 
    end
    
    
    while loop do -- Needed for collision detection
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
        
        for i,wall in ipairs(walls) do
            for j,obj in ipairs (objects) do
                local collision = obj:resolveCollision(wall)
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
    
    for i,v in ipairs (walls) do -- Have to draw them separately from objects.
       v:draw() 
    end
end

function love.keypressed(key) - All key presses checked here using this callback.
    if key == "space" then 
       player:jump()
    end
end