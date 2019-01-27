package;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import openfl.Assets;
import openfl.display.BitmapData;

class Room 
{
	private static inline var WALL_COL:Int = 0;
	private static inline var ENTRANCE_COL:Int = 0x0000ff;
	private static inline var TROPHY_COL:Int = 0xffff00;
	private static inline var SPIKES_COL:Int = 0xff0000;
	
	private static inline var UP_ARROW_COL:Int = 0x00f100;
	private static inline var DOWN_ARROW_COL:Int = 0x00a100;
	private static inline var LEFT_ARROW_COL:Int = 0xff7700;
	private static inline var RIGHT_ARROW_COL:Int = 0xff3300;
	
	private static inline var ROOM_WIDTH:Int = 20;
	private static inline var ROOM_HEIGHT:Int = 20;
	
	private var bmpDat:BitmapData;
	
	public var walls(default, null):FlxSpriteGroup = null;
	public var entrance(default, null):FlxPoint = null;
	public var spikes(default, null):FlxTypedGroup<Spikes> = null;
	public var arrowTraps(default, null):FlxTypedGroup<ArrowTrap> = null;
	public var allArrows(default, null):FlxTypedGroup<Arrow> = null;
	
	public var floor(default, null):FlxBackdrop = null;
	
	public function new(path:String, wallImg:FlxGraphicAsset, floorImg:FlxGraphicAsset)
	{
		bmpDat = Assets.getBitmapData('assets/data/' + path + '.png');
		floor = new FlxBackdrop(floorImg, 0, 0);
		
		loadWalls(wallImg);
		loadEntrance();
		loadSpikes();
		loadArrowTraps();
	}
	
	private function loadWalls(wallImg:FlxGraphicAsset):Void
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
	
	private function loadEntrance():Void
	{
		for (i in 0...(ROOM_WIDTH * ROOM_HEIGHT))
		{
			var tileX:Int = Math.floor(i % ROOM_WIDTH);
			var tileY:Int = Math.floor(i / ROOM_WIDTH);
			
			if (bmpDat.getPixel(tileX, tileY) == ENTRANCE_COL)
			{
				entrance = new FlxPoint(tileX * 16, tileY * 16);
				break;
			}
		}
	}
	
	private function loadSpikes():Void
	{
		spikes = new FlxTypedGroup<Spikes>();
		
		for (i in 0...(Room.ROOM_WIDTH * Room.ROOM_HEIGHT))
		{
			var tileX:Int = Math.floor(i % Room.ROOM_WIDTH);
			var tileY:Int = Math.floor(i / Room.ROOM_WIDTH);
			
			if (bmpDat.getPixel(tileX, tileY) == SPIKES_COL)
			{
				var s:Spikes = new Spikes(tileX * 16, tileY * 16);
				spikes.add(s);
			}
		}
	}
	
	private function loadArrowTraps():Void
	{
		arrowTraps = new FlxTypedGroup<ArrowTrap>();
		allArrows = new FlxTypedGroup<Arrow>();
		
		for (i in 0...(Room.ROOM_WIDTH * Room.ROOM_HEIGHT))
		{
			var tileX:Int = Math.floor(i % Room.ROOM_WIDTH);
			var tileY:Int = Math.floor(i / Room.ROOM_WIDTH);
			
			var direction:Direction = Direction.NONE;
			if (bmpDat.getPixel(tileX, tileY) == UP_ARROW_COL)
			{
				direction = Direction.UP;
			}
			else
			if (bmpDat.getPixel(tileX, tileY) == DOWN_ARROW_COL)
			{
				direction = Direction.DOWN;
			}
			else
			if (bmpDat.getPixel(tileX, tileY) == LEFT_ARROW_COL)
			{
				direction = Direction.LEFT;
			}
			else
			if (bmpDat.getPixel(tileX, tileY) == RIGHT_ARROW_COL)
			{
				direction = Direction.RIGHT;
			}
			
			if (direction != Direction.NONE)
			{
				var at:ArrowTrap = new ArrowTrap(tileX * 16, tileY * 16, direction, allArrows);
				arrowTraps.add(at);
			}
		}
	}
}