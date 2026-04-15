//Read languages.txt to see what languages are available
var file = file_text_open_read("data/lang/languages.txt");

global.languages = [];

while (!file_text_eof(file))
{
    var line = file_text_read_string(file);
    file_text_readln(file); // move to next line
    
    array_push(global.languages, line);
}

file_text_close(file);

//Set the first line in the array as default language
global.locale = global.languages[global.display.language];
InitTranslations();

function InitTranslations()
{
    global.locale = global.languages[global.display.language];

    var base = "data/lang/" + global.locale + "/";

    // Load CSV
    global.locData = load_csv(base + global.languages[global.display.language] + ".csv");

    var hh = ds_grid_height(global.locData);
    var translations = ds_map_create();

    for (var i = 0; i < hh; i++)
    {
        ds_map_add(translations, global.locData[# 0, i], i);
    }

    global.translations = translations;

    LoadLanguageFont(base);
	LoadLanguageFlag(base);
}

function LoadLanguageFont(_path)
{
    var font_path = _path + global.languages[global.display.language] + ".ttf";

    if (file_exists(font_path))
    {
        // Remove previous font
        if (font_exists(global.display.languageFont))
        {
			if(global.display.languageFont != global.defaultFont)
			{
				font_delete(global.display.languageFont);
			}
        }

        // Create font
        global.display.languageFont = font_add(font_path, 24, false, false, 32, 127);
    }
    else
    {
        // Remove previous font
        if (font_exists(global.display.languageFont))
        {
			if(global.display.languageFont != global.defaultFont)
			{
				font_delete(global.display.languageFont);
			}
        }
		
        // default font
        global.display.languageFont = global.defaultFont;
    }
}

function LoadLanguageFlag(_path)
{
    var flag_path = _path + "flag.png";

    // Delete previous flag
    if (sprite_exists(global.display.languageFlag))
    {
		if(global.display.languageFlag != global.defaultFlag)
		{
			sprite_delete(global.display.languageFlag);
		}
    }

    // If flag exists
    if (file_exists(flag_path))
    {
        global.display.languageFlag = sprite_add(flag_path, 1, false, false, 0, 0);
    }
    else
    {
        global.display.languageFlag = global.defaultFlag;
    }
}

//Grab CSV translation and find key
function Text(key)
{
	var text = "";
	
	if(global.translations[? key] != undefined)
	{
		//Get language file and load the 2 column and see if key matches
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