function postCreate()
{
	house.color = FlxColor.GRAY;

	var it = 0;

	for (struml in strumLines.members)
	{
		for (char in struml.characters)
		{
			var dropShadow = getDropShadow(char);

			dropShadow.setAdjustColor(-30, -32, 50, -60);

			dropShadow.antialiasAmt = 4;
			dropShadow.threshold = 0.1;
			dropShadow.distance = 20;
			dropShadow.angle = 90 - 4;

			switch (it)
			{
				case 1:
					dropShadow.angle = 105;
					dropShadow.threshold = 0.35;
				case 2:
					dropShadow.angle = 90;
			}

			dropShadow.color = FlxColor.fromRGB(69, 69, 69);
		}

		it++;
	}
}