if(startFading = true)
{
	image_alpha -= flashfade;
}

if(image_alpha < 0)
{
	instance_destroy();
}