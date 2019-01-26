package;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import openfl.Assets;
import openfl.display.BitmapData;

class Room 
{
	private static inline var WALL_COL:Int = 0;
	private static inline var ENTRANCE_COL:Int = 0x0000ff;
	private static inline var EXIT_COL:Int = 0x00ff00;
	private static inline var TREASURE_COL:Int = 0xffff00;
	
	private static inline var ROOM_WIDTH:Int = 20;
	private static inline var ROOM_HEIGHT:Int = 20;
	
	private var bmpDat:BitmapData;
	
	public var walls(default, null):FlxSpriteGroup = null;
	public var entrance(default, null):FlxPoint = null;
	public var exitDoor(default, null):ExitDoor = null;
	
	public var floor(default, null):FlxBackdrop = null;
	
	public function new(path:String, wallImg:FlxGraphicAsset, floorImg:FlxGraphicAsset)
	{
		bmpDat = Assets.getBitmapData('assets/data/' + path + '.png');
		floor = new FlxBackdrop(floorImg, 0, 0);
		
		loadWalls(wallImg);
		loadEntrance();
	}
	
	public function loadWalls(wallImg:FlxGraphicAsset)
	{
		walls = new FlxSpriteGroup();
		
		for (i in 0...(ROOM_WIDTH * ROOM_HEIGHT))
		{
			var tileX:Int = Math.floor(i % ROOM_WIDTH);
			var tileY:Int = Math.floor(i / ROOM_WIDTH);
			
			if (bmpDat.getPixel(tileX, tileY) == WALL_COL)
			{
				var w:Wall = new Wall(tileX * 16, tileY * 16, wallImg);
				walls.add(w);
			}
		}
	}
	
	public function loadEntrance()
	{
		for (i in 0...(ROOM_WIDTH * ROOM_HEIGHT))
		{
			var tileX:Int = Math.floor(i % ROOM_WIDTH);
			var tileY:Int = Math.floor(i / ROOM_WIDTH);
			
			if (bmpDat.getPixel(tileX, tileY) == ENTRANCE_COL)
			{
				entrance = new FlxPoint(tileX * 16, tileY * 16);
			}
		}
	}
}