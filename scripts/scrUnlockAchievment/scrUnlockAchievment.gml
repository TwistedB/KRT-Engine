/// @function UnlockAchievement(_name)
/// @param _name
function UnlockAchievement(_name)
{
	if (variable_struct_exists(global.achievements, _name))
	{
		global.achievements[$ _name].unlocked = true;
	}
}

/// @function IsAchievementUnlocked(_name)
/// @param _name
function IsAchievementUnlocked(_name)
{
	if (variable_struct_exists(global.achievements, _name))
	{
		return global.achievements[$ _name].unlocked;
	}
	
	return false;
}