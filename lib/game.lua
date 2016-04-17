local class = require "3rdparty/middleclass"

Game = class('Game')


function Game:initialize(endsReached, advanceToEndgame)
	self.advanceToEndgame = advanceToEndgame
	self.endsReached = endsReached
end

function Game:start()

end

function Game:draw()
end

function Game:update(dt)

end

function Game:keyPress(key)
	if key == ' ' then
        PlayClip(i)
    end
	i = i + 1
end

function Game:mousePressed(x, y, button)
	PlayClip(i)
	i = i + 1
end