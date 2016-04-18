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
	local y = 48
	local unreachedEnds = 0
	if self.endsReached.good then
		love.graphics.print("You've managed to finish the game with no casualties, well done!", 20, y)
		y = y + 14
	else
		unreachedEnds = unreachedEnds + 1
	end
	if self.endsReached.bad then
		love.graphics.print("You've managed to die for being a Shapeshifter!", 20, y)
		y = y + 14
	else
		unreachedEnds = unreachedEnds + 1
	end
	if self.endsReached.tommy then
		love.graphics.print("You've killed Tommy for being a Shapeshifter.", 20, y)
		y = y + 14
	else
		unreachedEnds = unreachedEnds + 1
	end
	if self.endsReached.bobby then
		love.graphics.print("You've killed Bobby for being a Shapeshifter.", 20, y)
		y = y + 14
	else
		unreachedEnds = unreachedEnds + 1
	end
	if self.endsReached.mike then
		love.graphics.print("You've killed Mike for being a Shapeshifter.", 20, y)
		y = y + 14
	else
		unreachedEnds = unreachedEnds + 1
	end
	y = y + 14
	if unreachedEnds ~= 0 then
		love.graphics.print("There are " .. unreachedEnds .. " endings you haven't discovered yet.", 20, y)
	else
		love.graphics.print("You've discovered all 5 endings, thank you for playing my game!", 20, y)
		y = y + 28
		love.graphics.print("If you're a fellow LD participant,\nplease leave a comment with your thoughts and criticism :)", 20, y)
	end
	y = y + 28
	love.graphics.print("Press any key to restart the game", 20, y)
end

function Endgame:update(dt)
end

function Endgame:keyPress(key)
	if key == ' ' or key == 'return' then
        self.advanceToGame()
		return
    end
end

function Endgame:mousePressed(x, y, key)
	self.advanceToGame()
end
