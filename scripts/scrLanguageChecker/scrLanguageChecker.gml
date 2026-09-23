function languageChecker()
{
	var languages = [];
	var searchPath = "data/lang/";

	var folder = file_find_first(searchPath + "*", fa_directory);

	while(folder != "")
	{
		array_push(languages, folder);
	
		folder = file_find_next()
	}

	show_debug_message("checking lang:" + string(languages));
	file_find_close();
	return(languages)
}