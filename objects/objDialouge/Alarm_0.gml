//show_message(string(myDialouge) + string(myCharacterEffects) + string(myCharacters) + string(myEvent) + string(myChoices))
//show_message(myDialouge)
checkDialougeEvent()
if(myCharacters[0][0] != -1 && !instance_exists(myCharacters[0][0]))
{
	var CA = instance_create_depth(110, 358, depth, myCharacters[0][0]);
	CA.dialougeObject = self;
	
	var eventsForTurn = []
	//for loop even
	for (var i = 0; i < array_length(myCharacters); ++i) {
	    if(i % 2 == 0)
		{
			for (var b = 1; b < array_length(myCharacters[i]); ++b) {
				array_push(eventsForTurn, myCharacters[i][b]);
			}
			array_push(CA.myEvents, eventsForTurn);
			eventsForTurn = []
		}
	}
}else if(instance_exists(myCharacters[0][0]))
{
	myCharacters[0][0].dialougeObject = self;
	myCharacters[0][0].myEvents = [];
	
	var eventsForTurn = []
	//for loop even
	for (var i = 0; i < array_length(myCharacters); ++i) {
	    if(i % 2 == 0)
		{
			for (var b = 1; b < array_length(myCharacters[i]); ++b) {
				array_push(eventsForTurn, myCharacters[i][b]);
			}
			array_push(myCharacters[0][0].myEvents, eventsForTurn);
			eventsForTurn = []
		}
	}
	with(objDCharacter)
	{
		CharacterEventCheck()
	}
}

if(myCharacters[1][0] != -1 && !instance_exists(myCharacters[1][0]))
{
	var CB = instance_create_depth(656, 358, depth, myCharacters[1][0]);
	CB.dialougeObject = self;
	
	var eventsForTurn = []
	//for loop odd
	for (var i = 0; i < array_length(myCharacters); ++i) {
	    if(i % 2 == 1)
		{
			for (var b = 1; b < array_length(myCharacters[i]); ++b) {
				array_push(eventsForTurn, myCharacters[i][b]);
			}
			array_push(CB.myEvents, eventsForTurn);
			eventsForTurn = []
		}
	}
}else if(instance_exists(myCharacters[1][0]))
{
	myCharacters[1][0].dialougeObject = self;
	myCharacters[1][0].myEvents = [];
	
	var eventsForTurn = []
	//for loop even
	for (var i = 0; i < array_length(myCharacters); ++i) {
	    if(i % 2 == 1)
		{
			for (var b = 1; b < array_length(myCharacters[i]); ++b) {
				array_push(eventsForTurn, myCharacters[i][b]);
			}
			array_push(myCharacters[1][0].myEvents, eventsForTurn);
			eventsForTurn = []
		}
	}
	
	with(objDCharacter)
	{
		CharacterEventCheck()
	}
}