io.stdout:setvbuf("no")

function saveData(fileName,table) -- Only call savedata on file we're sure is blank since we'll overwrite
    -- Formatting goes here
    local tab = "    "
    starter = ("return { \n")
    
    dataToWrite = tab .. "TEST TEST TEST, \n" .. tab .. "Something," -- data we'll end up writing to file
    -- Loop through data table, put next values on each new line until I reach an array type.
    
    -- Saving dictionaries?
    for i in ipairs (table) do
        
    end
    
    love.filesystem.write(fileName .. ".txt",starter .. dataToWrite .. "\n}") -- Saving formatted data goes here
end

function loadData(fileName)
    -- Just need to link the table's together.
    -- After loading the chunk in, I'm left with an array of arrays.
    -- I loop through array 1, if I reach another array type, then check the contents and based on the contents the next value in my curent array is equal to whatever the chunk returns from that index, after this
    -- has been appended in, just continue looping through array 1. This should work for 2d arras,
    -- for multi-dimensional arrays, when a new array has been identified and is about to be appended, loop through it too.
    
    local dataTable -- Correctly formatted loaded in data
   --Load it in and return the table :) There is a love function that does most of this for us. 
   
   return dataTable
end

function love.load()
    print(love.filesystem.getAppdataDirectory()) -- Check what this does on new school machine, if LOVE doesn't exist create it, and create file with name of project within it.
    Object = require "classic"
    
    require "entity"
    require "player"
    require "wall"
    require "box"
    require "platform"
    
    player = Player(100,100)
    -- Create a file using newFile, open it, write to it, then close it.
    saveData("Something", {1,5,2,"Hello","there!"})
    
    frameCounter  = 0
    targetFrameCount = nil
    
    objects = {} -- Needed so we update them all as a group and not have to update/draw objects individually, since they all have their own draw/update methods
    walls = {} -- Needed for walls because they don't need to check collision with each other, only objects in the objects table
    
    table.insert(objects,player)
    table.insert(objects,wall)
    table.insert(objects,box1)
    table.insert(objects,box2)
    table.insert(walls, platform1)
    table.insert(walls, platform2)
    
       map = {
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,1,0,0,0,0,3,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
    } -- Tilemap
    
    for i,v in ipairs(map) do -- Builds the tilemap
        for j,w in ipairs(v) do -- Nested loop so can use the iterators as X,Y values
            if w == 1 then -- 1 == a block
               table.insert(walls,Wall((j-1)*50, (i-1)*50))  -- Insert a wall in the position j-1 so that the first wall at index 1 gets put to 0 and from there each wall gets placed next to each other.
            elseif w == 2 then -- Platform
                table.insert(walls,Platform((j-1)*50, (i-1)*50))
                
            elseif w == 3 then -- Box
                table.insert(objects,Box((j-1)*50, (i-1)*50))
            end
        end
    end
end

function love.update(dt)
    local loop = true -- Debounce
    local limit = 0 -- For setting a loop limit so if a collision error happens, the program doesn't get trapped in an infinite loop
    
    frameCounter = frameCounter + 1
    
    for i,v in ipairs (objects) do -- Update all objects in objects list
        v:update(dt)
    end
    
    for i,v in ipairs (walls) do -- Because of separate arrays, need to update them separately
       v:update(dt) 
    end
    
    
    while loop do -- Needed for collision detection
        loop = false
       
        limit = limit + 1
        
        if limit > 100 then -- limit is 100 on iterations, "hop limit"
            break
        end
        
        for i=1,#objects-1 do -- Nested loop is needed to check collision with every other object that isn't themselves, uses maths to avoid repeating checks.
            for j=i+1,#objects do
                local collision = objects[i]:resolveCollision(objects[j])
                
                if collision then
                    loop = true
                end
            end
        end
        
        for i,wall in ipairs(walls) do -- For objects that do not collide with other like objects, they check between all of themselves versus everything in the objects table, no small calculations needed.
            for j,obj in ipairs (objects) do
                local collision = obj:resolveCollision(wall) -- Called in this way so that the wall doesn't move. object using this method will always end up being the one adjusted for collisions.
                if collision then
                    loop = true
                end
            end
        end
    end
end

function love.draw()
    love.graphics.scale(0.5,0.5)
    love.graphics.translate(-player.x + love.graphics:getWidth()/2,-player.y + love.graphics:getHeight()/0.75)
    for i,v in ipairs (objects) do
        v:draw()
    end
    
    for i,v in ipairs (walls) do -- Have to draw them separately from objects.
       v:draw()
    end
end

function love.keypressed(key) -- All key presses checked here using this callback.
    if key == "space" and not player.canWallJump then 
       player:jump()
    elseif key == "space" and not player.isWallJumping then
        player.canWallJump = false
        player.isWallJumping = true
        player.weight = 0
        player.gravity = 0
        targetFrameCount = frameCounter + 15 -- Is it ok to use the same targetFrame var name for this???
        
    
    elseif ((key == "x" and not player.canJump) and player.canDash) and player.speed ~= 0 then
        player.dashBegun = true
        player.weight = 0 
        player.gravity = 0
        targetFrameCount = frameCounter + 10
        cooldownFrameCount = targetFrameCount + 120
    end
end