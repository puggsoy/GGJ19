package;
import flixel.group.FlxSpriteGroup;
import openfl.Assets;
import openfl.display.BitmapData;

class Room 
{
	private static inline var ROOM_WIDTH:Int = 20;
	private static inline var ROOM_HEIGHT:Int = 20;
	
	public var walls(default, null):FlxSpriteGroup;
	
	public function new(path:String)
	{
		var data:BitmapData = Assets.getBitmapData('assets/data/' + path + '.png');
		
		walls = new FlxSpriteGroup();
		
		for (i in 0...(ROOM_WIDTH * ROOM_HEIGHT))
		{
			var tileX:Int = Math.floor(i % ROOM_WIDTH);
			var tileY:Int = Math.floor(i / ROOM_WIDTH);
			
			if (data.getPixel(tileX, tileY) == 0)
			{
				var w:Wall = new Wall(tileX * 16, tileY * 16);
				walls.add(w);
			}
		}
	}
}