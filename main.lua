function CalculateForce(xpos, ypos, xcenter, ycenter)
	local rx = xcenter - xpos
	local ry = ycenter - ypos
	local mod = rx^2 + ry^2
	local arg = 2 * math.atan(ry / (math.sqrt(mod) + rx))
	mod = math.pow(mod, 0.037037) * 8
	return mod * math.cos(arg), mod * math.sin(arg)
end

function love.load()
	love.window.setFullscreen(true)
	math.randomseed(os.time())
	dofile("ParticleClass.lua")
	PartArray = {}
	local ScreenWidth = love.graphics.getWidth()
	local ScreenHeight = love.graphics.getHeight()
	Nparticles = 4000
	for i=1,Nparticles do
		PartArray[i] = Particle:new{xpos = ScreenWidth * math.random(), ypos = ScreenHeight * math.random(),
	xvel = 0, yvel = 0}
	end
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end

function love.draw()
	for i,v in ipairs(PartArray) do
	local x,y = love.mouse.getPosition()		
	local r = (v.xpos - x)^2 + (v.ypos - y)^2
		r = math.pow(r, 0.5)
		b = 0
		if r > 255 then 
			b = r - 255 
			r = 255
		end
		if b > 255 then b = 255 end
		love.graphics.setColor(255, r, b)
		love.graphics.points(v.xpos, v.ypos)
	end
end

function love.update(dt)
	local x,y = love.mouse.getPosition()
	for i=1,Nparticles do
		local xfor, yfor = CalculateForce(PartArray[i].xpos, PartArray[i].ypos, x, y)
		PartArray[i]:move(xfor, yfor, dt)
	end

end
