Particle = {xpos = 0, ypos = 0, xvel = 0, yvel = 0}

function Particle:new (o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function Particle:move (xfor, yfor, dt)
	self.xvel = self.xvel + xfor * dt
	self.yvel = self.yvel + yfor * dt
	self.xpos = self.xpos + self.xvel * dt
	self.ypos = self.ypos + self.yvel * dt
end
