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
function Dialouge(key)
{
	var text = ["", -1, -1];
	
	//Get language file and load the first column and see if key matches
	if(global.translations[? key] != undefined)
	{
		//pick out the second line and grab translation text
		//Text
		text[0] = global.locData[# 1, global.translations[? key]]
		var a = argument_count > 1 ? argument[1] : "";
		text[0] = string_replace_all(text[0], "{a}", a);
		
		//Portrait
		text[1] = global.locData[# 2, global.translations[? key]]
		var b = argument_count > 2 ? argument[2] : "";
		text[1] = string_replace_all(text[1], "{b}", b);
		
		if(text[1] != -1)
		{
			text[1] = asset_get_index(text[1])
		}
		
		//Name
		text[2] = global.locData[# 3, global.translations[? key]]
		var c = argument_count > 3 ? argument[3] : "";
		text[2] = string_replace_all(text[2], "{c}", c);
		
		//Effect
		text[3] = global.locData[# 4, global.translations[? key]]
		var d = argument_count > 4 ? argument[4] : "";
		text[3] = string_replace_all(text[3], "{d}", d);
	}else
	{
		// if it doesnt return text
		text = key;
	}
	
	//Load the text that is related to the key and return as a string
	return text;
}

//Ill make a better version with portraits later i guess
//doing it now lol