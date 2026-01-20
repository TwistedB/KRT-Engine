/// @function TalkText(dialouge, name, portraitA, portraitB);
/// @param {array} _dialouge
/// @param {array} _characterA
/// @param {array} _characterB
/// @param {array} _event
function TalkText(_dialouge, _characterA, _characterB, _event){
	var dio = 0;
	textObj = instance_create_depth(0, 0, -200, objDialouge);
	
	textObj.myDialouge = _dialouge;
	
	var CE1 = [];
	var CE2 = [];
	
	if(is_string(_characterA))
	{
		_characterA = scr_parse_dollar_tags(_characterA, CE1);
		_characterA = asset_get_index(_characterA[0])
	}
	
	if(is_string(_characterB))
	{
		_characterB = scr_parse_dollar_tags(_characterB, CE2);
		_characterB = asset_get_index(_characterB[0])
	}
	
	textObj.myCharacters = [_characterA, _characterB];
	textObj.myCharacterEffects[0] = CE1;
	textObj.myCharacterEffects[1] = CE2;
	textObj.myEvent = _event;
}

/// @function Talk(key);
/// @param {array} _key
/// @param {array} _choices
/// @param {real} _destroyEvent
function Talk(_key, _choices, _destroyEvent){
	_choices = is_undefined(_choices) ? [-1, -1, -1] : _choices;
	_destroyEvent = is_undefined(_destroyEvent) ? -1 : _destroyEvent;
	//setting object to -1 for some reason
	textObj = instance_create_depth(0, 0, -200, objDialouge);
	textObj.myDestroyEvent = _destroyEvent;
	
	//array_push(textObj.myCharacters, _key[0][1]);
	//array_push(textObj.myCharacters, _key[0][3])

	for (var i = 0; i < array_length(_key); ++i) {
		var characterA = [_key[i][1]]
		var characterB = [_key[i][3]]
		array_push(textObj.myDialouge, _key[i][0])
		// pushing double array
		for (var a = 0; a < array_length(_key[i][2]); ++a) {
			var ar = _key[i][2]
			
			//making array for character A
			array_push(characterA, ar[a])
			
		    array_push(textObj.myCharacterEffects, ar[a])
		}
		
		for (var b = 0; b < array_length(_key[i][4]); ++b) {
			var ar = _key[i][4]
			
			//making array for character B
			array_push(characterB, ar[b])
			
		    array_push(textObj.myCharacterEffects, ar[b])
		}
		
		array_push(textObj.myCharacters, characterA);
		array_push(textObj.myCharacters, characterB);
		array_push(textObj.myEvent, _key[i][5])
	}
	
	if(_choices[0] != -1)
	{
		textObj.myChoices = _choices;
	}
}

/// @function TalkAddCharacter(object, events);
/// @param {array} _characterObject
/// @param {array} _characterEvents
function TalkAddCharacter(_characterObject, _characterEvents)
{
	if(instance_exists(objDialouge))
	{
		var CO = instance_create_depth(x, y, objDialouge.depth, _characterObject);
		CO.myEvents = [_characterEvents]
	}
}

function CharacterEventCheck()
{
	if(myEvents[dialougeObject.message_current] != "-1")
	{
		for (var i = 0; i < array_length(myEvents[dialougeObject.message_current]); ++i) {
			//Trigger if starts with $
			if(string_char_at(myEvents[dialougeObject.message_current][i], 1) = "$")
			{
				//change sprite
				if(string_char_at(myEvents[dialougeObject.message_current][i], 2) = "S")
				{
					var del = string_delete(myEvents[dialougeObject.message_current][i], 0, 2);
					var toNum = real(del);
					spriteSelector = toNum;
				}

				//change x
				if(string_char_at(myEvents[dialougeObject.message_current][i], 2) = "X")
				{
					var del = string_delete(myEvents[dialougeObject.message_current][i], 0, 2);
					var toNum = real(del);
					x = toNum;
				}
			
				//change y
				if(string_char_at(myEvents[dialougeObject.message_current][i], 2) = "Y")
				{
					var del = string_delete(myEvents[dialougeObject.message_current][i], 0, 2);
					var toNum = real(del);
					y = toNum;
				}
				
				//flip
				if(string_char_at(myEvents[dialougeObject.message_current][i], 2) = "F")
				{
					var del = string_delete(myEvents[dialougeObject.message_current][i], 0, 2);
					var toNum = real(del);
					if(toNum = 1)
					{
						image_xscale = -1;
					}
				}
				
				//current talking
				if(string_char_at(myEvents[dialougeObject.message_current][i], 2) = "T")
				{
					var del = string_delete(myEvents[dialougeObject.message_current][i], 0, 2);
					var toNum = real(del);
					if(toNum = 1)
					{
						currentlyTalking = true;
					}else
					{
						currentlyTalking = false;
					}
				}
			}
		}
	}
}