t++;
r++;
r2++;

if(r > 255)
{
	r = 0;
}

if(r2 > 255)
{
	r2 = 0;
}

if(spamDelay > 0)
{
	spamDelay -= 1;
}