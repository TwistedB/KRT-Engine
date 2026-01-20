//Put sprites here
characterSprites = [sprKidP1];

spriteSelector = 0;

sprite_index = characterSprites[spriteSelector];

myName = "Null"

//$S1 = sprite, $X1 = X position, $Y1 = Y position, $E1 = event, $F1 = flip, $T = current talking
//Add events here
myEvents = [];

//greys out if not talking
currentlyTalking = false;

dialougeObject = null;
x = 32;
y = 128;

lerpX = x;
lerpY = y;
lerpSpeed = 1;



alarm[0] = 1;

