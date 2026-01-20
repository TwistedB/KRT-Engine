/// @function UnlockAchievment(name);
/// @param {array} _name
function UnlockAchievment(_name){
	for (var i = 0; i < array_length(global.achievements); ++i) {
	    if(_name = global.achievements[i][0])
		{
			global.achievements[i][2] = true;
		}
	}
}