package;

import flixel.group.FlxGroup;
import flixel.input.FlxPointer;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;

class DungeonRoom extends Room 
{
	public var trophy(default, null):Trophy = null;
	
	public function new(path:String) 
	{
		super(path, 'assets/images/Dungeon Wall 1.png', 'assets/images/Dungeon Floor 1.png');
		
		loadTrophyLocation();
	}
	
	private function loadTrophyLocation():Void
	{
		for (i in 0...(Room.ROOM_WIDTH * Room.ROOM_HEIGHT))
		{
			var tileX:Int = Math.floor(i % Room.ROOM_WIDTH);
			var tileY:Int = Math.floor(i / Room.ROOM_WIDTH);
			
			if (bmpDat.getPixel(tileX, tileY) == Room.TROPHY_COL)
			{
				trophy = new Trophy(tileX * 16, tileY * 16);
				break;
			}
		}
	}
}