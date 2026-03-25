function scrVNGUI(){
	draw_set_font(font);
	draw_set_colour(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

function VNtypeText()
{
	if(textWaitTimer > 0)
	{
		textWaitTimer--;
		return;
	}

	timer++;

	if(timer >= currentTypeSpeed)
	{
		timer = 0;
		cutoff++;

		//Text Effect handling
		while(textEffectReadIndex < array_length(textEffects) && textEffects[textEffectReadIndex].pos == cutoff)
		{
			var e = textEffects[textEffectReadIndex];

			switch(e.type)
			{
				case "speed":
					currentTypeSpeed = e.value;
				break;

				case "wait":
					textWaitTimer = e.value;
				break;

				case "shake":
					textShake = e.value;
				break;
			}

			textEffectReadIndex++;
		}

		text = string_copy(textFull, 1, cutoff);
	}

	if(cutoff >= string_length(textFull))
	{
		text = textFull;
		state = STATE_VN.WAIT_INPUT;
	}
}

//used to linebreak proper
function VNWrapText(_text, _maxWidth)
{
	draw_set_font(font);

	var words = string_split(_text, " ");
	var line = "";
	var result = "";

	for(var i = 0; i < array_length(words); i++)
	{
		var test = line + words[i] + " ";

		if(string_width(test) > _maxWidth)
		{
			result += line + "\n";
			line = words[i] + " ";
		}
		else
		{
			line = test;
		}
	}

	result += line;

	return result;
}

function VNParseEffects(_text)
{
    var clean = "";
    var effects = [];

    var i = 1;
    var len = string_length(_text);

    while(i <= len)
    {
        var ch = string_char_at(_text, i);

        if(ch == "[")
        {
            var rest = string_copy(_text, i, len - i + 1);
            var closePos = string_pos("]", rest);

            if(closePos > 0)
            {
                var tag = string_copy(rest, 2, closePos - 2);
                var pos = string_length(clean) + 1;

                //color
                if(string_copy(tag, 1, 6) == "color=")
                {
                    var col = string_delete(tag, 1, 6);
                    var colValue = c_white;

                    switch(col)
                    {
                        case "red":   colValue = c_red;   break;
                        case "blue":  colValue = c_blue;  break;
                        case "green": colValue = c_green; break;
                        case "white": colValue = c_white; break;
                    }

                    array_push(effects, {pos: pos, type: "color", value: colValue});
                }

                if(tag == "/color")
                {
                    array_push(effects, {pos: pos, type: "color", value: c_white});
                }

                // shake
                if(tag == "shake")
                {
                    array_push(effects, {pos: pos, type: "shake", value: true});
                }

                if(tag == "/shake")
                {
                    array_push(effects, {pos: pos, type: "shake", value: false});
                }

                // shlow
				if(tag == "slow")
				{
					array_push(effects,{pos:pos,type:"speed",value:4});
				}

				if(tag == "/slow")
				{
					array_push(effects,{pos:pos,type:"speed",value:typeSpeed});
				}

                // wait
                if(string_copy(tag, 1, 5) == "wait=")
                {
                    var amount = real(string_delete(tag, 1, 5));
                    array_push(effects, {pos: pos, type: "wait", value: amount});
                }

                i += closePos;
                continue;
            }
        }

        clean += ch;
        i++;
    }

    return {
        text: clean,
        effects: effects
    };
}

function VNRemapEffectsToWrapped(_wrappedText, _effects)
{
	var whereThingsGo = [];
	var textSpot = 1;
	var wrappedTextLength = string_length(_wrappedText);

	// figure out where each normal text character ended up after line breaks got added
	for(var i = 1; i <= wrappedTextLength; i++)
	{
		var currentLetter = string_char_at(_wrappedText, i);

		if(currentLetter != "\n")
		{
			whereThingsGo[textSpot] = i;
			textSpot++;
		}
	}

	// also store the spot after the final character
	whereThingsGo[textSpot] = wrappedTextLength + 1;

	var newEffects = [];

	for(var i = 0; i < array_length(_effects); i++)
	{
		var a = _effects[i];
		var newSpot = a.pos;

		if(array_length(whereThingsGo) > a.pos && !is_undefined(whereThingsGo[a.pos]))
		{
			newSpot = whereThingsGo[a.pos];
		}

		array_push(newEffects,
		{
			pos: newSpot,
			type: a.type,
			value: a.value
		});
	}

	return newEffects;
}

function drawVNText(_drawStartX = 33, _drawStartY = 586)
{
	var textStartX = _drawStartX;
	var textX = textStartX;
	var textY = _drawStartY;

	var currentCol = c_white;
	var currentShake = false;
	var currentEffectNum = 0;

	var currentTextChunk = "";

	for(var i = 1; i <= cutoff; i++)
	{
		while(currentEffectNum < array_length(textEffects) && textEffects[currentEffectNum].pos == i)
		{
			if(currentTextChunk != "")
			{
				draw_set_colour(currentCol);

				var drawChunkX = textX;
				var drawChunkY = textY;

				if(currentShake)
				{
					drawChunkX += irandom_range(-2, 2);
					drawChunkY += irandom_range(-2, 2);
				}

				draw_text(drawChunkX, drawChunkY, currentTextChunk);
				textX += string_width(currentTextChunk);
				currentTextChunk = "";
			}

			switch(textEffects[currentEffectNum].type)
			{
				case "color":
					currentCol = textEffects[currentEffectNum].value;
				break;

				case "shake":
					currentShake = textEffects[currentEffectNum].value;
				break;
			}

			currentEffectNum++;
		}

		var currentLetter = string_char_at(textFull, i);

		if(currentLetter == "\n")
		{
			if(currentTextChunk != "")
			{
				draw_set_colour(currentCol);

				var lineChunkX = textX;
				var lineChunkY = textY;

				if(currentShake)
				{
					lineChunkX += irandom_range(-2, 2);
					lineChunkY += irandom_range(-2, 2);
				}

				draw_text(lineChunkX, lineChunkY, currentTextChunk);
				currentTextChunk = "";
			}

			textX = textStartX;
			textY += string_height("A");
			continue;
		}

		currentTextChunk += currentLetter;
	}

	if(currentTextChunk != "")
	{
		draw_set_colour(currentCol);

		var finalChunkX = textX;
		var finalChunkY = textY;

		if(currentShake)
		{
			finalChunkX += irandom_range(-2, 2);
			finalChunkY += irandom_range(-2, 2);
		}

		draw_text(finalChunkX, finalChunkY, currentTextChunk);
	}

	draw_set_colour(c_white);
}

function drawVNBacklog()
{
	var startX = 33;
	var startY = 50;
	var maxWidth = room_width - 40;

	draw_set_colour(c_black);
	draw_set_alpha(0.4);
	draw_rectangle(0, 0, room_width, room_height, false);
	draw_set_alpha(1);
	draw_set_colour(c_white);

	var yPos = startY - backlogScroll;

	backlogMaxScroll = 0;

	for(var i = 0; i < array_length(global.backlog); i++)
	{
		var lineText = global.backlog[i][0] + global.backlog[i][1];
		var textHeight = string_height_ext(lineText, 32, maxWidth);

		if(yPos + textHeight >= startY && yPos <= room_height)
		{
			draw_text_ext(startX, yPos, lineText, 32, maxWidth);
		}

		yPos += textHeight + 10;
		backlogMaxScroll += textHeight + 10;
	}

	backlogMaxScroll = max(0, backlogMaxScroll - (room_height - startY));
	
	if(backlogGoToBottom = true)
	{
		backlogScroll = backlogMaxScroll;
		backlogGoToBottom = false;
	}
}