//Put sprites here
characterSprites = [sprThingP1, sprThingP2, sprThingP3];

spriteSelector = 0;

//$S1 = sprite, $X1 = X position, $Y1 = Y position, $E1 = event, $F1 = flip, $T = current talking
//Add events here
myEvents = [];

myName = "Thing"

//greys out if not talking
currentlyTalking = false;

dialougeObject = null;
x = 656;
y = 358;

lerpX = x;
lerpY = y;
lerpSpeed = 1;

alarm[0] = 1;

