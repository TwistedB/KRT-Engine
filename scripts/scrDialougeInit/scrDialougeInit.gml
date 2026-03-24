/*
  An explanation so i dont forget like 99% of my other dialouge systems
  Each advance isnt a line, but what happens after you press continue after the line is finished reading
  speaker: is the text on the nameplate lable
  texts: is the text
  
  textEffects (enter these inside of texts: to do effects)
  [color=][/color] sets the color of text
  [wait=] makes text wait for a certain amount of frames
  [shake][/shake] makes text shake
  [slow][/slow] makes text slow
  
  characters:
  id: who the character actually is, needed so it knows what portrait to update/remove/focus later
  focusId: used to focus on a character, enter the characters id here to focus
  focusOff: turns off focus
  sprite: the portrait sprite
  pos: where they should stand on screen, like left/center/right/far_left/etc..
  enterAnim: how they come onto the screen like slide_left slide_right fade
  exitAnim: how they leave the screen mainly used when remove:true is on
  remove: if true removes that character from the screen
  alpha: changes portrait transparency
  scale: changes portrait size
  shake: makes portrait shake
  
  event_start and event_end run a event when the dialouge begins or end
  event_choose is exclusive to choice
  goto moves dialouge to a different line
  a line doesnt need to have dialouge
  tspeed: changes text speed
  player_move: enables or disables player movement after dialogue ends
  autoAdvance: auto advances text once it ends or continues to next event after a frame if theres no text in it
  autoModeSpeed: Changes the auto mode speed in which it takes to move to next line
  modeLock: locks the modes so it cant be changed by player
  modeHide: hides the GUI for the modes
  modeSet: changes the mode
  sound: plays audio on advance start
  do NOT do instance_destroy() in choices it crashes the game use VNEnd() instead
*/

function scrTestDialouge(){
	return
	[
		//Advance 1
		{ 
			speaker: "Test",
			texts: Text("A1"),
			sound: sndExample,
			characters: [
				{sprite:sprExamplePortrait, side:"left"},
				{sprite:sprExamplePortrait, side:"right"}
			],
			event_start: function(){show_debug_message("bleh")},
		},
		
		//Advance 2
		{ 
			speaker: "Test 2",
			texts: Text("A2"),
			characters: [
				{sprite:sprExamplePortrait, side:"left", off:true},
				{sprite:sprExamplePortrait, side:"right"}
			]
		},
		
		//Advance 3
		{ 
			choice: true,
			
			choices:[
				{
					texts:"End please!",
					event_choose: function(){scrDialouge(scrTestDialouge2())}
				},
				{
					texts:"Restart please!",
					goto: 0
				}
			]
		},
	]
}

function scrTestDialouge2(){
	return
	[
		//Advance 1
		{ 
			speaker: "Test",
			texts: Text("textC"),
			characters: [
				{sprite:sprExamplePortrait, side:"left"},
				{sprite:sprExamplePortrait, side:"right"}
			],
			event_start: function(){show_debug_message("bleh")},
		},
		
		//Advance 2
		{ 
			speaker: "Test 2",
			texts: Text("textD"),
			characters: [
				{sprite:sprExamplePortrait, side:"left", off:true},
				{sprite:sprExamplePortrait, side:"right"}
			]
		},
		
		//Advance 3
		{ 
			choice: true,
			
			choices:[
				{
					texts:"End please!",
					event_choose: function(){VNEnd()}
				},
				{
					texts:"Restart please!",
					goto: 0
				}
			]
		},
	]
}