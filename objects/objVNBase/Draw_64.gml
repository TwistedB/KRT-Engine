scrVNGUI();
VNportraitHandling()

//dialouge box
var boxWidth = 6;
var boxHeight = 1.66;

draw_sprite_ext(sprVNDialougeBox, 0, 16, 432, boxWidth, boxHeight, 0, c_white, 1);

//dio text
drawVNText(33, 442)

//nameplate
var nameplateWidth = (string_width(nameplateText)/128)+0.3
if(nameplateText != "")
{
	draw_sprite_ext(sprVNDialougeBox, 0, 16, 368, nameplateWidth, 0.5, 0, c_white, 1);
}
draw_text_ext(33, 376, nameplateText, 10, 1024)

//Mode Text
if(modeHide == false)
{
	if(mode == MODE_VN.SKIP)
	{
		draw_text(33, 50, "SKIPPING");
	}

	if(mode == MODE_VN.AUTO)
	{
		draw_text(33, 50, "AUTO");
	}
}

//Choice drawing
if(state == STATE_VN.CHOICE)
{
	var c = advance.choices;

	for(var i = 0; i < array_length(c); i++)
	{
		var yx = 490 + (i * 40);

		var prefix = "   ";

		if(i == choiceIndex)
		{
			prefix = "> ";
		}

		draw_text(33, yx, prefix + c[i].texts);
	}
}

if(backlogOpen = true)
{
	drawVNBacklog()
}