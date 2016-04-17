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
			response = {37},
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

local knowledge = {
	tommy = {1},
	mike = {24},
	bobby = {47},
}

local tellAbout = {
	tommy = {
		tommy = {6},
		bobby = {2, 42, 3, 43, 4},
		mike = {5},
	},
	bobby = {
		tommy = {48, 22},
		bobby = {50},
		mike = {49, 38},
	},
	mike = {
		tommy = {25, 20, 26},
		bobby = {27},
		mike = {28},
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
	},
	backtomain = {
		target = 'main',
		actor = false,
	},

	talktommy = {
		actor = 'tommy',
		target = 'talk2',
	},
	talkbobby = {
		actor = 'bobby',
		target = 'talk2',
	},
	talkmike = {
		actor = 'mike',
		target = 'talk2',
	},
	know = {
		caption = 'What do you know about Shapeshifters?',
		target = 'talk2',
	},
	tell = {
		caption = 'What can you tell me about...',
		target = 'tell',
	},
	backtalktommy = {
		caption = 'back...',
		target = 'talktommy'
	},
	accuse = {
		caption = 'I think the Shapeshifter is...',
		target = 'accuse',
	},
	accuseyou = {
		caption = 'You',
	},
	accusetommy = {
		caption = 'Tommy',
	},
	accusebobby = {
		caption = 'Bobby',
	},
	accusemike = {
		caption = 'Mike',
	},
	ask = {
		caption = 'Who do you think the shapeshifter is?',
		target = 'talk2',
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
	talk2 = {
		dynamic = true,
		-- 'tommyknow',
		-- 'tommytell',
		-- 'accuse',
		-- 'ask',
	},
	tell = {
		dynamic = true,
		-- 'tommytelltommy',
		-- 'tommytellbobby',
		-- 'tommytellmike',
		-- 'backtalktommy',
	},
	accuse = {
		dynamic = true,
	},
	accuse2 = {
		dynamic = true,
	}
}

function Game:tell()

end

function Game:talk2()
	self.currentOptions = {"know", "tell", "accuse", "ask"}
	transitions['know'].clips = knowledge[self.actor]
	transitions['ask'].clips = accusations[self.actor][self.accusations[self.actor]].response
	transitions['back'] = {
		caption = 'back',
		target = 'talk',
		actor = false,
	}
	self.currentOptions[#self.currentOptions + 1] = 'back'
end


function Game:accuse2()
	self.currentOptions = {"opt1", "opt2", "opt3", "opt4"}
	local options = accusations[self.actor][self.accusee].options
	local i = 1
	for caption, data in pairs(options) do
		local clips = {}
		for j = 2,#data do
			clips[j-1] = data[j]
		end
		transitions['opt' .. i] = {
			caption = caption,
			clips = clips,
			target = 'talk2',
			changeMind = data[1],
		}
		i = i + 1
	end
	transitions['back'] = {
		caption = 'back',
		target = 'talk2',
	}
	self.currentOptions[#self.currentOptions + 1] = 'back'
end

function Game:accuse()
	local myAccusations = accusations[self.actor]
	self.currentOptions = {}

	for k, v in pairs({'tommy', 'bobby', 'mike'}) do
		--terrible hack
		local transitionName
		if self.actor ~= v then
			transitionName = 'accuse' .. v
		else
			transitionName = 'accuseyou'
		end
		self.currentOptions[#self.currentOptions + 1] = transitionName
		if myAccusations[v].ask then
			transitions[transitionName].clips = myAccusations[v].ask
			transitions[transitionName].target = 'accuse2'
			transitions[transitionName].accusee = v
		else
			transitions[transitionName].clips = self.accusations[self.actor] == v and myAccusations[v].agree or myAccusations[v].disagree
			transitions[transitionName].target = 'talk2'
			transitions[transitionName].accusee = nil
		end
	end
	transitions['back'] = {
		caption = 'back',
		target = 'talk2',
	}
	self.currentOptions[#self.currentOptions + 1] = 'back'
end


function Game:startTransition(transitionName)
	local transition = transitions[transitionName]
	if transition.changeMind then
		self.accusations[self.actor] = self.accusee
	end
	if transition.actor ~= nil then
		self.actor = transition.actor
	end
	self.accusee = transition.accusee
	self.nextState = transition.target
	self.currentClips = transition.clips or {}
	self.currentClip = 0
	self.currentOptions = nil
	self:Skip()
end

function Game:NextState()
	self.currentClips = nil
	self.currentClip = nil
	self.currentState = self.nextState
	self.nextState = nil

	if states[self.currentState].dynamic then
		self[self.currentState](self)
	else
		self.currentOptions = states[self.currentState]
	end
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
	self.currentOptions = nil
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
	local options = self.currentOptions
	local y = 48
	for i, option in pairs(options) do
		local caption = transitions[option] and transitions[option].caption or option
		love.graphics.print("" .. i .. ") " .. caption, 20, y)
		y = y + 14
	end
end

function Game:update(dt)

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
	local options = self.currentOptions
	if options[i] then
		self:startTransition(options[i])
	end
end

function Game:mousePressed(x, y, button)
	self:Skip()
end