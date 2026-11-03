function create() {
	game.camHUD.visible = false;
	game.dad.visible = false;

	cutchar = new Character(0, 0, "flipflopCutscene", false);
	cutchar.setPosition(game.dad.x, game.dad.y);
	add(cutchar);

	FlxG.sound.play(Paths.sound("flipflopCutscene"));
	new FlxTimer().start(2.1, function(t) {
		cutchar.playAnim("end");
		new FlxTimer().start(2, function(t) {
			cutchar.visible = false;
			game.dad.visible = true;
			close();
		});
	});
}

function destroy() {
	game.dad.visible = true;
	game.camHUD.visible = true;
}
