function postCreate()
{
	house.color = FlxColor.GRAY;

	var it = 0;

	for (struml in strumLines.members)
	{
		for (char in struml.characters)
		{
			char.useRenderTexture = true;
			
			var dropShadow = getDropShadow(char);

			dropShadow.setAdjustColor(-6, -10, -20, 5);

			dropShadow.antialiasAmt = 12;
			dropShadow.threshold = -1;
			dropShadow.distance = 8;
			dropShadow.angle = 92;

			dropShadow.color = FlxColor.fromRGB(69, 69, 69);
		}

		it++;
	}
}

function augItUp(durBeats)
{
	if (FlxG.random.int(0, 20) != 0 || isMayoTime)
	{
		FlxTween.tween(aug, {x: 2500}, (Conductor.crochet / 1000) * Std.parseInt(durBeats));		
	}
}

var isMayoTime:Bool = false;