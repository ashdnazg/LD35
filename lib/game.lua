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
				["The telly!"] = {true, 55},
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
		caption = "How can we know if someone is a Shapeshifter?",
		clips = {18, 23, 41, 19},
		target = 'main',
	},
	isittommy = {
		caption = "Is Tommy the shapeshifter?",
		clips = {14},
		tommyState = 1,
		target = 'isittommy'
	},
	backtomain = {
		caption = 'back',
		target = 'main',
		actor = false,
	},

	talktommy = {
		caption = 'Tommy',
		actor = 'tommy',
		target = 'talk2',
	},
	talkbobby = {
		caption = 'Bobby',
		actor = 'bobby',
		target = 'talk2',
	},
	talkmike = {
		caption = 'Mike',
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
	blametommy = {
		caption = 'Tommy',
	},
	blamebobby = {
		caption = 'Bobby',
	},
	blamemike = {
		caption = 'Mike',
	},
	tellyou = {
		caption = 'Yourself',
	},
	telltommy = {
		caption = 'Tommy',
	},
	tellbobby = {
		caption = 'Bobby',
	},
	tellmike = {
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
		'talk',
		'blame',
	},
	groupask = {
		'howcanweknow',
		'isittommy',
		'backtomain',
	},
	blame = {
		dynamic = true,
		-- 'blametommy',
		-- 'blamemike',
		-- 'blamebobby',
		-- 'backtomain',
	},
	blame2 = {
		dynamic = true,
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
	},
	isittommy = {
		dynamic = true
	}
}

local tommyTransitions = {
	{
		caption = "Are we sure it's not Tommy?",
		clips = {63},
	},
	{
		caption = "Are we really sure it’s Tommy?",
		clips = {64},
	},
	{
		caption = "All signs seem to point that Tommy is the Shapeshifter",
		clips = {55},
	},
	{
		caption = "So it must be Tommy",
		clips = {15},
	},
	{
		caption = "Tommy",
		clips = {16},
	},
	{
		caption = "Tommy",
		clips = {63},
	},
	{
		caption = "Tommy",
		clips = {50},
	},
	{
		caption = "But what if it isn't Tommy?",
		clips = {44},
	},
	{
		caption = "Maybe it's like when we killed Fred the other week thinking he was a werewolf?",
		clips = {81, 65},
	},
	{
		caption = "No, there is no shapeshifter!",
		clips = {7, 61},
	},
}


function Game:blame2()

end

function Game:blame()
	self.currentOptions = {'blametommy', 'blamebobby', 'blamemike', 'back'}
	for _, v in pairs({'tommy', 'bobby', 'mike'}) do
		local clips = {}
		local transitionName = 'blame' .. v
		local canBlame = self.accusations.tommy == v and self.accusations.bobby == v and self.accusations.mike == v
		local clips
		if canBlame then
			clips = {72, 71, 69}
			if v == "bobby" then
				clips[#clips + 1] = 70
			end
			clips[#clips + 1] = 73
		else
			clips = {}
			if self.accusations.tommy ~= v then
				clips[#clips + 1] = 21
			end
			if self.accusations.mike ~= v then
				clips[#clips + 1] = 40
			end
			if self.accusations.bobby ~= v then
				clips[#clips + 1] = 62
			end
			clips[#clips + 1] = 68
			clips[#clips + 1] = 39
			clips[#clips + 1] = 67
			clips[#clips + 1] = 69
			clips[#clips + 1] = 66
		end
		transitions[transitionName].clips = clips
		transitions[transitionName].endType = canBlame and v or 'bad'
	end


	transitions['back'] = {
		caption = 'back',
		tommyState = 1,
		target = 'main',
	}
end


function Game:isittommy()
	self.currentOptions = {'nexttommy', 'back'}
	local currentTommy = self.tommyState
	if currentTommy > #tommyTransitions then
		self.endsReached.good = true
		self:advanceToEndgame()
		return
	end

	transitions['nexttommy'] = tommyTransitions[currentTommy]
	transitions['nexttommy'].tommyState = currentTommy + 1
	transitions['nexttommy'].target = 'isittommy'

	transitions['back'] = {
		caption = 'back',
		tommyState = 1,
		target = 'main',
	}
end


function Game:tell()
	local myTell = tellAbout[self.actor]
	self.currentOptions = {}

	for _, v in pairs({'tommy', 'bobby', 'mike'}) do
		--terrible hack
		local transitionName
		if self.actor ~= v then
			transitionName = 'tell' .. v
		else
			transitionName = 'tellyou'
		end
		self.currentOptions[#self.currentOptions + 1] = transitionName
		transitions[transitionName].clips = tellAbout[self.actor][v]
		transitions[transitionName].target = 'talk2'
	end
	transitions['back'] = {
		caption = 'back',
		target = 'talk2',
	}
	self.currentOptions[#self.currentOptions + 1] = 'back'
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
	if transition.tommyState ~= nil then
		self.tommyState = transition.tommyState
	end
	if transition.endType then
		self.endsReached[transition.endType] = true
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
	if not self.currentState then
		self:advanceToEndgame()
		return
	end

	if states[self.currentState].dynamic then
		self[self.currentState](self)
	else
		self.currentOptions = states[self.currentState]
	end
end

function Game:initialize(endsReached, advanceToEndgame)
	self.advanceToEndgame = advanceToEndgame
	self.endsReached = endsReached
	self.images = {
		B = love.graphics.newImage("assets/img/bobby.png"),
		M = love.graphics.newImage("assets/img/mike.png"),
		T = love.graphics.newImage("assets/img/tommy.png"),
		A = love.graphics.newImage("assets/img/telly.png"),
		default = love.graphics.newImage("assets/img/all.png"),
	}
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
	local t = {
		tommy = 'T',
		bobby = 'B',
		mike = 'M',
	}
	local talking = self.talking or (self.actor and t[self.actor]) or ''
	local image = self.images[talking] or self.images.default
	love.graphics.draw(image)
	if self.caption then
		love.graphics.print(self.caption, 20, 405)
		return
	end
	local options = self.currentOptions
	local y = 405
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
	if options and options[i] then
		self:startTransition(options[i])
	end
end

function Game:mousePressed(x, y, button)
	self:Skip()
end