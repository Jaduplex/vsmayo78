final id = "Change Character";
final CHAR_STRUMLINE = 0;
final STRUMLINE_INDEX = 1;
final CHAR_ID = 2;
final chars = [];

function onEvent(e)
{
	final e = e.event;
	if (e.name == id)
	{
		final i = e.params[CHAR_STRUMLINE];
		final char = e.params[STRUMLINE_INDEX];
		final strumLine = strumLines.members[i];

		final curChar = strumLine.characters[char];
		if (curChar != null) curChar.visible = false;

		final newChar = chars[i].get(e.params[CHAR_ID]);

		var idx = strumLine.characters.indexOf(newChar);
		if (idx == -1) idx = strumLine.characters.length;

		newChar.visible = true;
		strumLine.characters[char] = newChar;
		if (curChar != null) strumLine.characters[idx] = curChar;
	}
}

function loadChar(id, strumIndex, strumlineId)
{
	final strumLine = strumLines.members[strumlineId];
	var charPosName:String = strumLine.data.position ?? ( switch (strumLine.data.type)
	{
		case 0:
			"dad";
		case 1:
			"boyfriend";
		case 2:
			"girlfriend";
	});
	if (!chars[strumlineId].exists(id))
	{
		final char = new Character(0, 0, id, stage.isCharFlipped(stage.characterPoses[id] != null ? id : charPosName, strumLine.data.type == 1));
		char.useRenderTexture = true;
		stage.applyCharStuff(char, charPosName, strumIndex);
		chars[strumlineId].set(id, char);
		char.visible = false;

		strumLine.characters.push(char); // so anims sync up

		// DUMB way of checking for multiple graphics
		var graphics = [];
		for (frame in char.frames.frames)
		{
			if (!graphics.contains(frame.parent)) graphics.push(frame.parent);
		}
		while (graphics.length > 0)
			graphicCache.cacheGraphic(graphics.pop());
	}
}

function create()
{
	for (i => strumline in strumLines.members)
	{
		chars[i] = ["" => null];
		for (char in strumline.characters) chars[i].set(char.curCharacter, char);
	}
	for (event in events)
	{
		if (event.name == id) loadChar(event.params[CHAR_ID], event.params[STRUMLINE_INDEX], event.params[CHAR_STRUMLINE]);
	}
}
