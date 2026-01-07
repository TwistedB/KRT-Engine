typewriter = 0
dialoguespeed = 2
dialogueid = 0
faceindex = 0
active = true
currentimage = 0
nextid = false
t = 0

dialogueimage = [sprPlayerIdle,sprPlayerRun,sprPlayerIdle]
dialoguetextchoice = [[":(", "why bro"], ["ok", ":)"]]
dialoguechoice = ["no","sure"]
choicecount = 0
choice = 1
drawntext = ""
text = ["yeah ok ", "fat", "blah$S2 you suck go$S5 fuck youself", "$S8 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "$S1choice? $C2"]
skipCounter = 0;

if(instance_exists(objPlayer))
{
	objPlayer.frozen = true;
}

function charat(pos)
{
    return string_char_at(text[dialogueid],pos)
}