/// scrDialouge(functionName)
function scrDialouge(_functionName){
	if(instance_exists(objVNBase))
	{
		with(objVNBase)
		{
			dialouge = _functionName;
			lineCurrent = 0;
			state = STATE_VN.START;
		}
	}else
	{
		var VN = instance_create_depth(x, y, depth, objVNBase)
		VN.dialouge = _functionName;
		VN.advance = VN.dialouge[0];
	}
}