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
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
