local class = require "3rdparty/middleclass"

local tween = require '3rdparty/tween'

Endgame = class('Endgame')

function Endgame:initialize(endsReached, advanceToGame)
	self.advanceToGame = advanceToGame
	self.endsReached = endsReached
end

function Endgame:start(endType)
end


function Endgame:draw()
end

function Endgame:update(dt)
end

function Endgame:keyPress(key)
end

function Endgame:mousePressed(x, y, key)
end
