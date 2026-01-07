/// @function Talk(dialouge, portraitNum, Name);
/// @param {array} _dialouge
/// @param {array} _portraitNum
/// @param {array} _name
function Talk(_dialouge, _portrait, _name, _effect){
	var dio = 0;
	textObj = instance_create_depth(0, 0, -200, objDialouge);
	
	textObj.myDialouge = [];
	textObj.myName = [];
	textObj.myPortrait = [];
	
	for (var i = 0; i < array_length(_dialouge); ++i) {
		dio[i] = Dialouge(_dialouge[i]);
		
		_portrait = is_undefined(_portrait) ? dio[i][1] : _portrait;
		_name = is_undefined(_name) ? dio[i][2] : _name;
		_effect = is_undefined(_effect) ? dio[i][3] : _effect;

		array_push(textObj.myDialouge, dio[i][0])
		array_push(textObj.myPortrait, dio[i][1])
		array_push(textObj.myName, dio[i][2])
	}
}