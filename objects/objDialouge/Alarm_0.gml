//show_message(string(myDialouge) + string(myCharacterEffects) + string(myCharacters) + string(myEvent) + string(myChoices))
//show_message(myDialouge)
checkDialougeEvent()
if(myCharacters[0][0] != -1)
{
	var CA = instance_create_depth(x, y, depth, myCharacters[0][0]);
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
}

if(myCharacters[1][0] != -1)
{
	var CB = instance_create_depth(x, y, depth, myCharacters[1][0]);
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
}