function postCreate()
{
	housen.color = FlxColor.GRAY;
}

function fadeBg()
{
	FlxTween.tween(sky, {alpha: 0}, Conductor.crochet / 250, {ease: FlxEase.sineInOut});
	FlxTween.tween(house, {alpha: 0}, Conductor.crochet / 250, {ease: FlxEase.sineInOut});
	FlxTween.tween(grass, {alpha: 0}, Conductor.crochet / 250, {ease: FlxEase.sineInOut});
}