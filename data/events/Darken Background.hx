var darkenTween:FlxTween;

function postCreate()
{
	darkenSolid = new FlxSprite().makeSolid(FlxG.width * 8, FlxG.height * 8, FlxColor.BLACK);
	darkenSolid.screenCenter();
	darkenSolid.scrollFactor.set();
	darkenSolid.alpha = 0;

	var lowestIndex:Int = 99999999999;
	for (i => strumLine in strumLines.members)
	{
		if (members.indexOf(strumLine.characters[0]) < lowestIndex)
		{
			lowestIndex = members.indexOf(strumLine.characters[0]);
		}
	}

	insert(lowestIndex, darkenSolid);
}

function onEvent(e)
{
	if (e.event.name == 'Darken Background')
	{
		if (darkenTween != null) darkenTween.cancel();

		var _val:Float = e.event.params[0];
		var _tweened:Bool = e.event.params[1];
		var _ease = CoolUtil.flxeaseFromString(e.event.params[2], e.event.params[3]);
		var _time:Float = ((conductor.crochet / 1000) / 4) * e.event.params[4];

		if (_tweened) darkenTween = FlxTween.tween(darkenSolid, {alpha: _val}, _time, {ease: _ease});
		else
			darkenSolid.alpha = _val;
	}
}
