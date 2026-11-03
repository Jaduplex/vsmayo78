// ITS ACTUALLY A SUFFIX BUT IM FUCKING STUPID OK IM SORRY
function onEvent(e)
{
	if (e.event.name == "Alt Anim Switch w Prefix")
	{
		var strumLine = strumLines.members[e.event.params[0]];

		if (strumLine == null)
		{
			return;
		}

		var affectIdle:Bool = e.event.params[2];
		var affectSinging:Bool = e.event.params[3];

		for (character in strumLine.characters)
		{
			if (affectIdle || affectIdle == null)
			{
				character.idleSuffix = e.event.params[1];
			}
		}

		if (affectSinging || affectSinging == null)
		{
			strumLine.animSuffix = e.event.params[1];
		}
	}
}
