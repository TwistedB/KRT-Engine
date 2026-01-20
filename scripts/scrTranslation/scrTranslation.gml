//Add later a file to add languages easily
global.languages = ["EN"]

//Set English as default language
global.locale = global.languages[0];
InitTranslations();

function InitTranslations()
{
	//Grabbing CSV file for selected language
	global.locData = load_csv("lang/" + global.locale + ".csv");
	
	var hh = ds_grid_height(global.locData);
	var translations = ds_map_create();
	
	for (var i = 0; i < hh; i++)
	{
		ds_map_add(translations, global.locData[# 0, i], i)
	}
	
	global.translations = translations;
}

//Use for basic lines without portraits
function Text(key)
{
	var text = "";
	
	//Get language file and load the first column and see if key matches
	if(global.translations[? key] != undefined)
	{
		//pick out the second line and grab translation text
		text = global.locData[# 1, global.translations[? key]]
		var a = argument_count > 1 ? argument[1] : "";
		text = string_replace_all(text, "{a}", a);
	}else
	{
		// if it doesnt return text
		text = key;
	}
	
	//Load the text that is related to the key and return as a string
	return text;
}

//used for lines with portraits
function TextD(key)
{
	var text = ["", -1, -1, -1, -1, -1];
	
	//Get language file and load the first column and see if key matches
	if(global.translations[? key] != undefined)
	{
		//pick out the second line and grab translation text
		//Text
		text[0] = global.locData[# 1, global.translations[? key]]
		var a = argument_count > 1 ? argument[1] : "";
		text[0] = string_replace_all(text[0], "{a}", a);
		
		//CharacterA
		text[1] = global.locData[# 2, global.translations[? key]]
		var b = argument_count > 2 ? argument[2] : "";
		text[1] = string_replace_all(text[1], "{b}", b);
		
		text[2] = []
		
		//CharacterA effects
		text[1] = scr_parse_dollar_tags(text[1], text[2]);

		if(text[1] != -1)
		{
			text[1] = asset_get_index(text[1])
		}
		
		//CharacterB
		text[3] = global.locData[# 3, global.translations[? key]]
		var c = argument_count > 3 ? argument[3] : "";
		text[3] = string_replace_all(text[3], "{c}", c);
	
		text[4] = []
		
		//CharacterB effects
		text[3] = scr_parse_dollar_tags(text[3], text[4]);
		
		if(text[3] != -1)
		{
			text[3] = asset_get_index(text[3])
		}
		
		//Event
		text[5] = global.locData[# 4, global.translations[? key]]
		var d = argument_count > 4 ? argument[4] : "";
		text[5] = string_replace_all(text[5], "{d}", d);
	}else
	{
		// if it doesnt return text
		text = key;
	}
	
	//Load the text that is related to the key and return as a string
	return text;
}

/// @function scr_parse_dollar_tags(_source_string, _tag_array)
/// @param _source_string  String containing $ tags
/// @param _tag_array      Array to push extracted $xx strings into
/// @return                Cleaned string with $ tags removed

function scr_parse_dollar_tags(_source_string, _tag_array)
{
    var result = "";
    var len = string_length(_source_string);
    var i = 1;

    while (i <= len)
    {
        var ch = string_char_at(_source_string, i);

        if (ch == "$" && i + 2 <= len)
        {
            // Extract "$" + next two characters
            var tag = string_copy(_source_string, i, 3);
            array_push(_tag_array, tag);

            // Skip "$xx"
            i += 3;
        }
        else
        {
            // Normal character, keep it
            result += ch;
            i++;
        }
    }

    return result;
}


//Ill make a better version with portraits later i guess
//doing it now lol