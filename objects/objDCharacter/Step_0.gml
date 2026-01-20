if(currentlyTalking = true)
{
	image_alpha =  lerp(image_alpha, 1, 0.2)
}else
{
	image_alpha =  lerp(image_alpha, 0.3, 0.2)
}

if(!instance_exists(objDialouge))
{
	instance_destroy()
}

x = lerp(x, lerpX, lerpSpeed)
y = lerp(y, lerpY, lerpSpeed)

sprite_index = characterSprites[spriteSelector];