function onEvent(e)
{
	if (e.event.name != "Hide HUD")
	{
		return;
	}
	var target = e.event.params[0] ? 0 : 1;
	FlxTween.tween(camHUD, {alpha: target}, e.event.params[1]);
}
