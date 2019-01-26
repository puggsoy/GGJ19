package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	private var player:Player = null;
	
	override public function create():Void
	{
		super.create();
		
		FlxG.mouse.useSystemCursor = true;
		bgColor = FlxColor.BROWN;
		
		player = new Player(100, 100);
		
		add(player);
		loadRoom();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	private function loadRoom():Void
	{
		var room:Room = new Room('lvl0');
		
		add(room.walls);
	}
}
