//Put sprites here
characterSprites = [sprKidP1, sprKidP2, sprKidP3];

spriteSelector = 0;

//$S1 = sprite, $X1 = X position, $Y1 = Y position, $E1 = event, $F1 = flip, $T = current talking
//Add events here
myEvents = [];

myName = "Kid"

//greys out if not talking
currentlyTalking = false;

dialougeObject = null;
x = 32;
y = 128;

lerpX = x;
lerpY = y;
lerpSpeed = 1;

alarm[0] = 1;

