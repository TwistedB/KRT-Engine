function scrJsonReader(_jsonName, _dialogueID)
{
    var file = file_text_open_read("dialogue/" + _jsonName + ".json");
    var jsonString = "";

    while(!file_text_eof(file))
    {
        jsonString += file_text_read_string(file);
        file_text_readln(file);
    }

    file_text_close(file);

    var data = json_parse(jsonString);

    if(!variable_struct_exists(data,_dialogueID))
    {
        show_debug_message("Dialogue not found: " + _dialogueID);
        return;
    }

    var dialogue = data[$ _dialogueID];

    for(var i = 0; i < array_length(dialogue); i++)
    {
        var line = dialogue[i];

        // language for speaker
        if(variable_struct_exists(line,"speaker"))
        {
            line.speaker = Text(line.speaker);
        }

        // language for text
        if(variable_struct_exists(line,"texts"))
        {
            line.texts = Text(line.texts);
        }

        // character sprites
		if(variable_struct_exists(line,"characters"))
		{
			var chars = line.characters;

			for(var j = 0; j < array_length(chars); j++)
			{
				var c = chars[j];

				if(variable_struct_exists(c,"sprite"))
				{
					var spriteName = c.sprite;
					var spriteIndex = asset_get_index(spriteName);

					if(spriteIndex == -1)
					{
						show_debug_message("JSON sprite not found: " + string(spriteName));
					}

					c.sprite = spriteIndex;
				}
			}
		}

        // event start ADD EVENTS HERE IF USING JSONS
        if(variable_struct_exists(line,"event_start"))
        {
            switch(line.event_start)
            {
                case "debug_test":
                    line.event_start = function(){show_debug_message("debug_test")};
                break;
            }
        }

        //choice stuff
        if(variable_struct_exists(line,"choices"))
        {
            var ch = line.choices;

            for(var k = 0; k < array_length(ch); k++)
            {
                if(variable_struct_exists(ch[k],"texts"))
                {
                    ch[k].texts = Text(ch[k].texts);
                }
				
				//Add events here as well (specifically choice events)
                if(variable_struct_exists(ch[k],"event_choose"))
                {
                    switch(ch[k].event_choose)
                    {
                        case "gototest2":
                            ch[k].event_choose = function()
                            {
                                scrJsonReader("testJson","scrTestDialouge2");
                            };
                        case "close":
                            ch[k].event_choose = function()
                            {
                                VNEnd();
                            };
                        break;
                    }
                }
            }
        }
    }

    scrDialouge(dialogue);
}