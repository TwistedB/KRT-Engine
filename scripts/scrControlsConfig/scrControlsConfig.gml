//Default main controls
global.controls = {
	left: {
		keyboard: vk_left,
		controller: gp_padl
	},
	
	right: {
		keyboard: vk_right,
		controller: gp_padr
	},
	
	up: {
		keyboard: vk_up,
		controller: gp_padu
	},
	
	down: {
		keyboard: vk_down,
		controller: gp_padd
	},
	
	jump: {
		keyboard: vk_shift,
		controller: gp_face1
	},
	
	shoot: {
		keyboard: ord("Z"),
		controller: gp_face3
	},
	
	restart: {
		keyboard: ord("R"),
		controller: gp_face4
	},
	
	pause: {
		keyboard: ord("P"),
		controller: gp_start
	},
	
	suicide: {
		keyboard: ord("Q"),
		controller: -1
	}
};

//Default menu controls
global.controls_menu = {
	left: {
		keyboard: vk_left,
		controller: gp_padl
	},
	right: {
		keyboard: vk_right,
		controller: gp_padr
	},
	up: {
		keyboard: vk_up,
		controller: gp_padu
	},
	down: {
		keyboard: vk_down,
		controller: gp_padd
	},
	accept: {
		keyboard: vk_shift,
		controller: gp_face1
	},
	back: {
		keyboard: ord("Z"),
		controller: gp_face2
	},
	options: {
		keyboard: vk_enter,
		controller: gp_start
	}
};

//Default misc. controls
global.controls_misc = {
	overlay: {
		keyboard: vk_backspace,
		controller: -1
	},
	screenshot: {
		keyboard: vk_f9,
		controller: -1
	},
	mute_music: {
		keyboard: ord("M"),
		controller: -1
	},
	fullscreen: {
		keyboard: vk_f4,
		controller: -1
	},
	reset: {
		keyboard: vk_f2,
		controller: -1
	},
	quit: {
		keyboard: vk_escape,
		controller: -1
	}
};