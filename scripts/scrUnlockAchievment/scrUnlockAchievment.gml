/// @function UnlockAchievment(name);
/// @param {array} _name
function UnlockAchievment(_name){
	for (var i = 0; i < array_length(global.achievments); ++i) {
	    if(_name = global.achievments[i][0])
		{
			global.achievments[i][2] = true;
		}
	}
}