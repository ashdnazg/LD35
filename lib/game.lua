local class = require "3rdparty/middleclass"
local clips = require 'lib/clips'

Game = class('Game')


local accusations = {
	tommy = {
		tommy = {
			ask = {8},
			options = {
				["Science told me"] = {false, 21},
				["It's the logical choice"] = {true, 10},
				["Can you prove you aren't?"] = {false, 7},
				["You sound like a duck"] = {false, 16},
			},
			response = {12},
		},
		bobby = {
			disagree = {21},
			agree = {7},
			response = {11},
		},
		mike = {
			ask = {8},
			options = {
				["Science told me"] = {true, 9},
				["He's the logical choice"] = {false, 17},
				["He can change his shape at will"] = {false, 17},
				["He never liked you anyway"] = {false, 17},
			},
			response = {13},
		},
	},

	mike = {
		tommy = {
			ask = {32},
			options = {
				["Look in his face"] = {false, 40},
				["Listen to his truth"] = {false, 40},
				["Look in his soul"] = {true, 25, 20, 26},
				["Listen to his spirit"] = {false, 40},
			},
			response = {36},
		},
		bobby = {
			ask = {32},
			options = {
				["Look in his face"] = {false, 40},
				["Listen to his truth"] = {true, 30, 44, 79, 45, 31},
				["Look in his soul"] = {false, 40},
				["Listen to his spirit"] = {false, 40},
			},
			response = {36},
		},
		mike = {
			agree = {29},
			disagree = {40},
			response = {34, 62, 21, 35},
		},
	},
	bobby = {
		tommy = {
			ask = {54},
			options = {
				["He's annoying"] = {false, 62},
				["He's obnoxious"] = {false, 62},
				["Why are you arguing?"] = {false, 62},
				["The telly!"] = {true, 40},
			},
			response = {59, 80, 60},
		},
		bobby = {
			ask = {51},
			options = {
				["All the cool guys are shapeshifters"] = {false, 62},
				["Why not?"] = {false, 45},
				["You can change into everything!"] = {true, 52},
				["Pretty please?"] = {false, 62},
			},
			response = {58},
		},
		mike = {
			agree = {53},
			disagree = {62},
			response = {57},
		},
	}
}


local transitions = {
	start = {
		clips = {74, 75, 76, 77, 78},
		target = 'main',
	},
	blame = {
		caption = "Blame...",
		target = 'blame',
	},
	talk = {
		caption = "Talk to...",
		target = 'talk',
	},
	groupask = {
		caption = "Ask the group...",
		target = 'groupask',
	},
	howcanweknow = {
		clips = {18, 23, 41, 19},
		target = 'main',
	},
	isittommy = {
		clips
	},
	backtomain = {
		target = 'main',
		actor = false,
	},
	blametommy = {

	},
	blamemmike = {

	},
	blamebobby = {

	},

	talktommy = {
		actor = 'tommy',
		target = 'talktommy',
	},
	talkbobby = {
		actor = 'bobby',
		target = 'talktommy',
	},
	talkmike = {
		actor = 'mike',
		target = 'talktommy',
	},

	tommyknow = {
		caption = 'What do you know about Shapeshifters?',
		clips = {1},
		target = 'talktommy',
	},
	tommytell = {
		caption = 'What can you tell me about...',
		target = 'tommytell',
	},
	tommytelltommy = {
		caption = 'Yourself',
		clips = {6},
		target = 'tommytell',
	},
	tommytellbobby = {
		caption = 'Bobby',
		clips = {2, 42, 3, 43, 4},
		target = 'tommytell',
	},
	tommytellmike = {
		caption = 'Mike',
		clips = {5},
		target = 'tommytell',
	},
	backtalktommy = {
		caption = 'back...',
		target = 'talktommy'
	},
	accuse = {
		caption = 'I think the Shapeshifter is...',
		target = 'accuse',
	},
}




local states = {
	main = {
		'groupask',
		'blame',
		'talk',
	},
	groupask = {
		'howcanweknow',
		'isittommy',
		'backtomain',
	},
	blame = {
		'blametommy',
		'blamemike',
		'blamebobby',
		'backtomain',
	},
	talk = {
		'talktommy',
		'talkmike',
		'talkbobby',
		'backtomain',
	},
	talktommy = {
		'tommyknow',
		'tommytell',
		'accuse',
		'tommyask',
	},
	tommytell = {
		'tommytelltommy',
		'tommytellbobby',
		'tommytellmike',
		'backtalktommy',
	},
	accuse = {
		func = accuse,
	},
}


local i = 1
function Game:startTransition(transitionName)
	local transition = transitions[transitionName]
	self.nextState = transition.target
	self.currentClips = transition.clips or {}
	self.currentClip = 0
	self:Skip()
end

function Game:initialize(endsReached, advanceToEndgame)
	self.advanceToEndgame = advanceToEndgame
	self.endsReached = endsReached
end

function Game:start()
	self.talking = nil
	self.caption = nil
	self.currentClips = nil
	self.currentClip = nil
	self.currentState = nil
	self.nextState = nil
	self.accusations = {
		tommy = 'bobby',
		mike = 'mike',
		bobby = 'mike',
	}

	self:startTransition('start')
end

function Game:draw()
	if self.caption then
		love.graphics.print(self.caption, 20, 48)
		return
	end
	local options = states[self.currentState]
	local y = 48
	for i, option in pairs(options) do
		local caption = transitions[option] and transitions[option].caption or option
		love.graphics.print("" .. i .. ") " .. caption, 20, y)
		y = y + 14
	end
end

function Game:update(dt)

end

function Game:NextState()
	self.currentClips = nil
	self.currentClip = nil
	self.currentState = self.nextState
	self.nextState = nil
end

function Game:switchToClip(id)
	self.talking, self.caption = clips.PlayClip(id)
end

function Game:Skip()
	if self.currentClips and self.currentClip then
		self.currentClip = self.currentClip + 1
		if self.currentClip > #self.currentClips then
			self:switchToClip(nil)
			self:NextState()
			return
		end
		self:switchToClip(self.currentClips[self.currentClip])
	end
end

function Game:keyPress(key)
	if key == ' ' or key == 'return' then
        self:Skip()
		return
    end
	if not self.currentState then
		return
	end

	local i = tonumber(key)
	local options = states[self.currentState]
	if options[i] then
		self:startTransition(options[i])
	end
end

function Game:mousePressed(x, y, button)
	self:Skip()
end