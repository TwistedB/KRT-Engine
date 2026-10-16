function play_music(music, loop, startPoint, loopStart, loopEnd) {
	if (!audio_is_playing(music)) {
		startPoint = is_undefined(startPoint) ? 0 : startPoint;
		loopStart = is_undefined(loopStart) ? -1 : loopStart;
		loopEnd = is_undefined(loopEnd) ? -1 : loopEnd;
		
	    audio_stop_sound(global.current_music);
		global.current_music = (!global.display.mute_music && music != -1) ? audio_play_sound(music, 0, loop, global.musicVolume, startPoint) : music;
		
		if(loopStart != -1)
		{
			audio_sound_loop_start(global.current_music, loopStart);
		}
		
		if(loopEnd != -1)
		{
			audio_sound_loop_end(global.current_music, loopEnd);
		}
	}
}

function stop_music() {
	if (global.current_music != -1) {
	    audio_stop_sound(global.current_music);
	    global.current_music = -1;
	}
}

function get_music() {
	var music = -1;
	var loop = true;
	var startPoint = 0;
	var loopStart = 0;
	var loopEnd = 0;
	
	if (!instance_exists(objPlayMusic)) {
		switch (room) {
			case rTitle:
			case rFiles:
			case rOptions:
			    music = global.default_music;
				loopStart = 7.677;
				loopEnd = 105.681;
				//Add additional stuff here
			    break;
		}
	} else {
		with (objPlayMusic) {
			music = self.music;
			loop = self.loop;
			startPoint = self.startPoint;
			loopStart = self.loopStart;
			loopEnd = self.loopEnd;
		}
	}

	if (music != -2) {
		play_music(music, loop, startPoint, loopStart, loopEnd);
	}
}

function toggle_music() {
	if (!global.display.mute_music) {
		get_music();  //Find and play the proper music for the current room
	} else { //Mute music
		audio_group_stop_all(audiogroup_BGM);
	}
}