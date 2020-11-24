Player = Entity:extend()

function Player:new(x,y)
   Player.super.new(self,x,y, "player.png") 
   
   self.strength = 50
   self.canJump = false
   self.canDash = true
   self.speed = 200
   self.last.speed = 200
   self.dashBegun = false
   self.canWallJump = false
   self.isWallJumping = false
   self.runDirectionOffset = nil
end

function Player:update(dt)
    Player.super.update(self,dt) -- So it inherits and slightly overrites the update function from the inherit class.
    local isZDown = love.keyboard.isDown("z")
    
    
    if not self.dashBegun and not player.isWallJumping then
        self.last.speed = self.speed
        if love.keyboard.isDown("left") then
            self.speed = -200
            self.runDirectionOffset = -1
        elseif love.keyboard.isDown("right") then
            self.speed = 200
            self.runDirectionOffset = 1
        else
            self.speed = 0
        end
    end
        
    if isZDown and not self.dashBegun then
        self.speed = self.speed * 2
    end
    
    
    if self.isWallJumping then
        self.speed = 0
        if frameCounter <= targetFrameCount then
            self.x = self.x + self.wallJumpOffset
            self.y = self.y - 5 
            -- Need to save the direction they're colliding from.
        else
            self.isWallJumping = false
            self.weight = 700
        end
    end
    
    if self.dashBegun then 
        if frameCounter <= targetFrameCount then
            self.speed = 800 * self.runDirectionOffset -- Can't be at 200 since that means speed isn't increasing so the player will just stop in place since their speed is set to 0 by controls.
        elseif frameCounter <= cooldownFrameCount then
            self.dashBegun = false
            self.canDash = false
            self.weight = 700
        end
    elseif not self.canDash and frameCounter >= cooldownFrameCount then
        self.canDash = true
    end
    
    
    self.x = self.x + self.speed * dt
    
    if  self.last.y ~= self.y then -- If their y has changed from the last recorded one, they're in the air, obviously
        self.canJump = false
    end
end

function Player:jump(dt) 
    if self.canJump then
       self.gravity = -400
       self.canJump = false
    end
end

function Player:dash(dt)
    self.gravity = 0 
end

function Player:collide(e,direction)
   Player.super.collide(self, e, direction)
   
    if direction == "bottom" then
        self.canJump = true
    end
    
    if e:is(Wall) then
        if direction == "left" then
            self.canWallJump = true
            self.wallJumpOffset = 5
        elseif direction == "right" then
            self.canWallJump = true
            self.wallJumpOffset = -5
        else
            self.canWallJump = false
        end
    end
end

function Player:checkResolve(e, direction)
    return true
end