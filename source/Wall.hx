package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

class Wall extends FlxSprite 
{
	private static inline var ROOM_NUM:Int = 1;
	
	private var currentRoom:Room = null;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		makeGraphic(16, 16, FlxColor.BLACK);
	}
}