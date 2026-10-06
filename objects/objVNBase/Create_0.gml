VNFont = fntTrajanus

with(objPlayer)
{
	objPlayer.frozen = true;
}

font_enable_effects(VNFont, true, 
{
	outlineEnable: true,
	outlineDistance: 4,
	outlineColor: c_black,
});

dioControls = {
	auto: {
		keyboard: ord("A"),
		controller: -1
	},
	
	skip: {
		keyboard: ord("S"),
		controller: -1
	},
	
	backlog: {
		keyboard: ord("G"),
		controller: -1
	},
	
	advance: global.controls.jump,
	up: global.controls.up,
	down: global.controls.down
};

backlogOpen = false;
backlogScroll = 0;
backlogMaxScroll = 0;
backlogGoToBottom = false;

timer = 0;
cutoff = 0;

playerMove = true;

autoAdvance = false;
autoTimer = 1;

maxAutoCounter = 100;
maxSkipCounter = 2;

autoCounter = maxAutoCounter;
skipCounter = maxSkipCounter;

portraitActors = [];

portraitBaseY = 420;
portraitMoveLerp = 0.15;
portraitFadeLerp = 0.15;
portraitScaleLerp = 0.15;

choiceIndex = 0;

typeSpeed = 1;

textEffects = [];
currentTypeSpeed = typeSpeed;
textWaitTimer = 0;
textShake = false;
textEffectReadIndex = 0;

nameplateText = ""
textFull = ""

text = ""

inputLock = 0;

dialouge = scrTestDialouge();
lineCurrent = 0;
advance = dialouge[0];

state = STATE_VN.START;
mode = MODE_VN.NORMAL;

modeLock = false
modeHide = false;