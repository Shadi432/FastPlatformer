Platform = Entity:extend()

function Platform:new(x,y)
    Platform.super.new(self,x,y, "platform.png")
    
    self.weight = 0
    self.strength = 100
end

function Platform:update(dt)
    Platform.super.update(self, dt)
end