// True holds has history.
import StringTools;

function onNoteHit(event)
{
	if (event.note.isSustainNote)
	{
		event.preventAnim();
	}

	if (StringTools.startsWith(event.note.animation.curAnim.name, 'holdend'))
	{
		for (char in event.note.strumLine.characters)
		{
			char.animation.timeScale = 1.0;

			var defHoldTime = Std.parseInt(char.xml.get("holdTime") ?? "4");
			if (Math.isNaN(defHoldTime))
			{
				defHoldTime = 4;
			}
			char.holdTime = defHoldTime;
			char.lastHit = Conductor.songPosition;
		}
	}
}

function postUpdate(e)
{
	for (strumLine in strumLines)
	{
		strumLine.notes.forEachAlive(checkNote);
	}

	for (strumLine in strumLines)
	{
		for (char in strumLine.characters)
		{
			if (char.animation.curAnim != null)
			{
				var endAutoIdle = 0 == Std.parseInt(char.xml.get("holdNoteEndAutoIdle")) ? true : false;

				if (!StringTools.startsWith(char.animation.curAnim.name, "sing"))
				{
					continue;
				}

				if (char.animation.curAnim.numFrames - 1 == char.animation.curAnim.curFrame && endAutoIdle)
				{
					char.dance();
					char.animation.finish();
				}
			}
		}
	}
}

function checkNote(note)
{
	if (!((note.strumLine.cpu || note.strumLine.__pressed[note.strumID]) && note.isSustainNote && note.wasGoodHit))
	{
		return;
	}

	if (StringTools.startsWith(note.animation.curAnim.name, 'holdend'))
	{
		return;
	}

	for (char in note.strumLine.characters)
	{
		var offset = Std.parseInt(char.xml.get("holdNoteOffset") ?? "2");
		var mult = Std.parseFloat(char.xml.get("holdNoteFPSmult") ?? "0.5");

		if (Math.isNaN(offset))
		{
			offset = 2;
		}

		if (Math.isNaN(mult))
		{
			mult = 0.5;
		}

		var isPastOffset = char.animation.curAnim.curFrame >= offset;
		char.animation.timeScale = isPastOffset ? mult : 1.0;
		char.holdTime = 9999999;
	}
}

function onPlayerMiss(event)
{
	for (char in event.characters)
	{
		char.animation.timeScale = 1;
		var defHoldTime = Std.parseInt(char.xml.get("holdTime") ?? "4");
		if (Math.isNaN(defHoldTime))
		{
			defHoldTime = 4;
		}
		char.holdTime = defHoldTime;
	}
}
