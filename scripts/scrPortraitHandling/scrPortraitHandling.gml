function VNPortraitGetPosX(_posName)
{
	switch(_posName)
	{
		case "far_left": return 16;
		case "left": return 150;
		case "mid_left": return 360;
		case "center": return 400;
		case "mid_right": return 440;
		case "right": return 650;
		case "far_right": return 784;
	}

	return 512;
}

function VNPortraitFindIndex(_id)
{
	for(var i = 0; i < array_length(portraitActors); i++)
	{
		if(portraitActors[i].id == _id)
		{
			return i;
		}
	}

	return -1;
}

function VNPortraitAdd(_id, _sprite, _posName, _enterAnim)
{
	if(is_undefined(_sprite) || _sprite == -1)
	{
		show_debug_message("Failed to add portrait for " + string(_id));
		return;
	}

	var goToX = VNPortraitGetPosX(_posName);
	var startX = goToX;
	var startAlpha = 1;

	if(_enterAnim == "slide_left")
	{
		startX = -200;
	}
	else if(_enterAnim == "slide_right")
	{
		startX = room_width + 200;
	}
	else if(_enterAnim == "fade")
	{
		startAlpha = 0;
	}

	var a =
	{
		id: _id,
		sprite: _sprite,

		xPos: startX,
		yPos: portraitBaseY,
		xGoTo: goToX,
		yGoTo: portraitBaseY,

		alphaNum: startAlpha,
		alphaGoTo: 1,

		col: c_white,
		colGoTo: c_white,

		xScaleNum: 1,
		yScaleNum: 1,
		xScaleGoTo: 1,
		yScaleGoTo: 1,

		shakeNum: 0,

		removeAfter: false
	};

	array_push(portraitActors, a);
}

function VNPortraitUpdate(_id, _data)
{
	var whichOne = VNPortraitFindIndex(_id);
	if(whichOne == -1) return;

	var a = portraitActors[whichOne];

	if(variable_struct_exists(_data, "sprite"))
	{
		a.sprite = _data.sprite;
	}

	if(variable_struct_exists(_data, "pos"))
	{
		a.xGoTo = VNPortraitGetPosX(_data.pos);
	}

	if(variable_struct_exists(_data, "alpha"))
	{
		a.alphaGoTo = _data.alpha;
	}

	if(variable_struct_exists(_data, "scale"))
	{
		a.xScaleGoTo = _data.scale;
		a.yScaleGoTo = _data.scale;
	}

	if(variable_struct_exists(_data, "shake"))
	{
		a.shakeNum = _data.shake;
	}

	portraitActors[whichOne] = a;
}

function VNPortraitRemove(_id, _exitAnim)
{
	var whichOne = VNPortraitFindIndex(_id);
	if(whichOne == -1) return;

	var a = portraitActors[whichOne];

	if(_exitAnim == "slide_left")
	{
		a.xGoTo = -200;
	}
	else if(_exitAnim == "slide_right")
	{
		a.xGoTo = room_width + 200;
	}

	a.alphaGoTo = 0;
	a.removeAfter = true;

	portraitActors[whichOne] = a;
}

function VNCharacters(_chars)
{
	for(var i = 0; i < array_length(_chars); i++)
	{
		var c = _chars[i];

		if(!variable_struct_exists(c, "id")) continue;

		var whichOne = VNPortraitFindIndex(c.id);

		// remove
		if(variable_struct_exists(c, "remove") && c.remove)
		{
			var exitType = "fade";

			if(variable_struct_exists(c, "exitAnim"))
			{
				exitType = c.exitAnim;
			}

			VNPortraitRemove(c.id, exitType);
			continue;
		}

		// add if it isnt already there
		if(whichOne == -1)
		{
			var enterType = "";
			var posType = "center";

			if(variable_struct_exists(c, "enterAnim")) enterType = c.enterAnim;
			if(variable_struct_exists(c, "pos")) posType = c.pos;

			VNPortraitAdd(c.id, c.sprite, posType, enterType);
			whichOne = VNPortraitFindIndex(c.id);
		}

		// update it after
		VNPortraitUpdate(c.id, c);
	}
}

function VNPortraitStep()
{
	for(var i = array_length(portraitActors) - 1; i >= 0; i--)
	{
		var a = portraitActors[i];

		a.xPos = lerp(a.xPos, a.xGoTo, portraitMoveLerp);
		a.yPos = lerp(a.yPos, a.yGoTo, portraitMoveLerp);

		a.alphaNum = lerp(a.alphaNum, a.alphaGoTo, portraitFadeLerp);

		a.xScaleNum = lerp(a.xScaleNum, a.xScaleGoTo, portraitScaleLerp);
		a.yScaleNum = lerp(a.yScaleNum, a.yScaleGoTo, portraitScaleLerp);

		a.col = merge_colour(a.col, a.colGoTo, 0.15);

		if(a.shakeNum > 0)
		{
			a.shakeNum = max(0, a.shakeNum - 0.2);
		}

		portraitActors[i] = a;

		if(a.removeAfter && a.alphaNum <= 0.05)
		{
			array_delete(portraitActors, i, 1);
		}
	}
}

function VNportraitHandling()
{
	for(var i = 0; i < array_length(portraitActors); i++)
	{
		var a = portraitActors[i];

		if(is_undefined(a.sprite) || a.sprite == -1) continue;

		var drawX = a.xPos;
		var drawY = a.yPos;

		if(a.shakeNum > 0)
		{
			drawX += irandom_range(-a.shakeNum, a.shakeNum);
			drawY += irandom_range(-a.shakeNum, a.shakeNum);
		}

		draw_sprite_ext(a.sprite, 0, drawX, drawY, a.xScaleNum, a.yScaleNum, 0, a.col, a.alphaNum);
	}
}

function VNPortraitFocus(_speakerId)
{
	for(var i = 0; i < array_length(portraitActors); i++)
	{
		var a = portraitActors[i];

		if(a.id == _speakerId)
		{
			a.colGoTo = c_white;
			a.xScaleGoTo = 1.05;
			a.yScaleGoTo = 1.05;
		}
		else
		{
			a.colGoTo = make_colour_rgb(120,120,120);
			a.xScaleGoTo = 0.95;
			a.yScaleGoTo = 0.95;
		}

		portraitActors[i] = a;
	}
}

function VNPortraitFocusOff()
{
	for(var i = 0; i < array_length(portraitActors); i++)
	{
		var a = portraitActors[i];

		a.colGoTo = c_white;
		a.xScaleGoTo = 1;
		a.yScaleGoTo = 1;
		a.alphaGoTo = 1;

		portraitActors[i] = a;
	}
}