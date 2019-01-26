package;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.math.FlxRandom;

class HomeRoom extends Room 
{
	private static inline var LAST_LOCATION_COL:Int = 0xff00ff;
	
	private var trophyLocations:Array<FlxPoint> = null;
	private var lastLocation:FlxPoint = null;
	public var trophies(default, null):FlxTypedGroup<Trophy> = null;
	
	public function new(path:String) 
	{
		super(path, 'assets/images/Home Room Wall.png', 'assets/images/Home Room Floor.png');
		loadTrophyLocations();
		trophies = new FlxTypedGroup<Trophy>();
	}
	
	private function loadTrophyLocations():Void
	{
		trophyLocations = new Array<FlxPoint>();
		
		for (i in 0...(Room.ROOM_WIDTH * Room.ROOM_HEIGHT))
		{
			var tileX:Int = Math.floor(i % Room.ROOM_WIDTH);
			var tileY:Int = Math.floor(i / Room.ROOM_WIDTH);
			
			if (bmpDat.getPixel(tileX, tileY) == Room.TROPHY_COL)
			{
				trophyLocations.push(new FlxPoint(tileX * 16, tileY * 16));
			}
			
			if (bmpDat.getPixel(tileX, tileY) == LAST_LOCATION_COL)
			{
				lastLocation = new FlxPoint(tileX * 16, tileY * 16);
			}
		}
	}
	
	public function placeTrophy(trophy:Trophy):Void
	{
		trophy.drop();
		
		if (trophyLocations.length == 0)
		{
			trophy.setPosition(lastLocation.x, lastLocation.y);
			trophies.add(trophy);
		}
		else
		{
			var num:Int = new FlxRandom().int(0, trophyLocations.length - 1);
			trophy.setPosition(trophyLocations[num].x, trophyLocations[num].y);
			trophyLocations.remove(trophyLocations[num]);
			trophies.add(trophy);
		}
	}
}