local clips = {
	[1] = {'T','You can use science to distinguish between humans and shapeshifters,\nso they must oppose science and the scientific method.'},
	[2] = {'T','I don\'t understand how he was invited into our group in the first place,\nforget shapeshifting, the guy can barely talk.'},
	[3] = {'T','But can we understand you? Without the subtitles...'},
	[4] = {'T','I rest my case'},
	[5] = {'T','He\'s a nice guy, his new age stuff can be annoying but harmless really.'},
	[6] = {'T','What kind of question is this? Is this a job interview?\nWell I\'m a team player and my main weakness is perfectionism'},
	[7] = {'T','Duh!'},
	[8] = {'T','What evidence do you have to support that?'},
	[9] = {'T','You\'ve made a good argument here, he\'s consistently undermining every \nlogical discussion we have with his spiritual gobbledigook.'},
	[10] = {'T','Hmm, you\'re right, if a shapeshifter came here I\'m the logical pick.\nI can\'t see how he could decide to impersonate anyone else in this room.\nYeah, I must be the shapeshifter.'},
	[11] = {'T','Bobby, It can only be Bobby'},
	[12] = {'T','As you said, I\'m the only logical choice here, it just has to be me'},
	[13] = {'T','You\'ve managed to convince me,\nMike\'s unscientific behaviour proves he\'s the shapeshifter beyond any reasonable doubt.'},
	[14] = {'T','I\'m not!'},
	[15] = {'T','Stop this!'},
	[16] = {'T','This is slander!'},
	[17] = {'T','This makes no sense at all'},
	[18] = {'T','Shapeshifters are non-human creatures that take human form,\nusing empirical evidence it must be possible to distinguish between the two'},
	[19] = {'T','You can think? That\'s clearly not Bobby'},
	[20] = {'T','At least I\'m in touch with reality, are you?'},
	[21] = {'T','Uhm, NO!'},
	[22] = {'T','You mean too smart for you'},
	[23] = {'M','No, man, you just gotta look into the soul'},
	[24] = {'M','Well, aren\'t we all shapeshifters?\nPeople don\'t show what\'s inside they go around wearing masks'},
	[25] = {'M','Dude\'s not here man, is he really in touch with his soul?'},
	[26] = {'M','I\'m in touch with everything, man, we\'re all connected bro'},
	[27] = {'M','Yeahhhhhhhhhh, Man, Bobby, haha! Good times!'},
	[28] = {'M','Weird stuff, man, the entire world seems like there\'s no free will,\nthat it\'s not me talking, someone else\'s words coming out from my mouth.\nIs that how you feel when you\'re a shapeshifter? Freaking me out, man.'},
	[29] = {'M','If that is your truth, that\'s enough for me'},
	[30] = {'M','You\'re absolutely right man, I feel so hard communicating with him,\nBobby what\'s your truth man'},
	[31] = {'M','A shapeshifter took Bobby\'s truth from him, man.'},
	[32] = {'M','Why would you say such a thing?'},
	[33] = {'M','I so get what you mean, all these attempts to hide what\'s really inside.\nOpen up Tommy, let us see the real Shapeshifter in you'},
	[34] = {'M','Well, man the only Shapeshifter I know is me, but aren\'t we all shapeshifters?\nI mean listen guys, isn\'t it the same voice talking through all of us?'},
	[35] = {'M','How can\'t you hear this?'},
	[36] = {'M','Well, Tommy is just the system shapeshifted into a soulless shell, makes me sad, man'},
	[37] = {'M','Bobby\'s truth just isn\'t there, man'},
	[38] = {'M','I ask myself the same question every day, man, That\'s Deep'},
	[39] = {'M','Just pay attention, when he\'s talking I feel like I can\'t really hear him, must be a shapeshifter'},
	[40] = {'M','I don\'t agree'},
	[41] = {'B','Well, I think...'},
	[42] = {'B','I can talk alright'},
	[43] = {'B','???'},
	[44] = {'B','What do you mean?'},
	[45] = {'B','I don\'t know'},
	[46] = {'B','No, mate, this is my own voice'},
	[47] = {'B','They are you but they aren\'t you, that\'s what the telly guy said'},
	[48] = {'B','Too smart for his own good'},
	[49] = {'B','Who is Mike?'},
	[50] = {'B','Uhhhhhh, yeah.'},
	[51] = {'B','Really?'},
	[52] = {'B','So I can be whatever I want? I can be rich? Alright, I\'m a Shapeshifter now'},
	[53] = {'B','Who? Never heard of him, sure, can be a Shapeshifter'},
	[54] = {'B','I don\'t like him, but why is he a Shapeshifter?'},
	[55] = {'B','Yeah, the man in the telly said it may be Tommy'},
	[56] = {'B','Of course you would say that'},
	[57] = {'B','It\'s the weird guy, over there'},
	[58] = {'B','I\'m a shapeshifter, I\'m shifting into a billionaire and also a helicopter'},
	[59] = {'B','Tommy, like the telly said'},
	[60] = {'B','Already happened, mate'},
	[61] = {'B','What a bummer'},
	[62] = {'B','What? No!'},
	[63] = {'B','Yeah it\'s Tommy'},
	[64] = {'B','Sure'},
	[65] = {'B','So Freddie was the shapeshifter!'},
	[66] = {'B','Stupid'},
	[67] = {'T','He\'s trying to turn us against each other'},
	[68] = {'T','Maybe he is the shapeshifter'},
	[69] = {'B','Let\'s kill him'},
	[70] = {'B','Hey wait, it\'s me'},
	[71] = {'M','That\'s just true, man'},
	[72] = {'T','Yes, I agree'},
	[73] = {'G','*Thump*'},
	[74] = {'A','And now for domestic news.'},
	[75] = {'A','A new menace has arrived to our peaceful country. Shapeshifters, who shift their shapes.'},
	[76] = {'A','It is estimated that one in four is a dangerous shapeshifter,\nthe public is encouraged to stay vigilant against this vicious enemy.'},
	[77] = {'A','If there are more than 3 people in your room,one of them may be a shapeshifter.\nMaybe it\'s Tommy.'},
	[78] = {'M','Feels like I\'ve already heard this'},
	[79] = {'M','Bobby what\'s your truth?'},
	[80] = {'T','And if the telly told you to jump off a cliff?'},
	[81] = ('M','Yeah, it was just a fake telly story to distract us from the government corruption'),
}

local currentSource

local _clips = {}

function _clips.PlayClip(id)
	if currentSource then
		currentSource:stop()
	end
	if not id or not clips[id] then
		return
	end
	currentSource = love.audio.newSource('assets/clips/' .. id .. '.ogg')
	currentSource:play()
	return clips[id][1], clips[id][2]
end

return _clips