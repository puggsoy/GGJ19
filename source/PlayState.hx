package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.math.FlxRandom;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	private var player:Player = null;
	
	private static inline var ROOM_TYPE_AMOUNT:Int = 2;
	private static inline var NUM_OF_ROOMS:Int = 3;
	private var roomNum:Int = 0;
	
	private var homeRoom:HomeRoom = null;
	private var currentRoom:Room;
	
	override public function create():Void
	{
		super.create();
		
		FlxG.mouse.useSystemCursor = true;
		bgColor = FlxColor.BROWN;
		
		loadHomeRoom();
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		FlxG.collide(player, currentRoom.walls);
		
		if (!player.isOnScreen())
		{
			roomNum++;
			if (roomNum > NUM_OF_ROOMS)
			{
				roomNum = 0;
				loadHomeRoom();
			}
			else
			{
				loadDungeonRoom();
			}
		}
	}
	
	private function loadHomeRoom():Void
	{
		if (homeRoom == null)
		{
			homeRoom = new HomeRoom('home');
		}
		
		currentRoom = homeRoom;
		
		initializeRoom();
	}
	
	private function loadDungeonRoom():Void
	{
		var num:Int = new FlxRandom().int(0, ROOM_TYPE_AMOUNT - 1);
		
		var room:DungeonRoom = new DungeonRoom('lvl' + num);
		
		currentRoom = room;
		
		initializeRoom();
	}
	
	private function initializeRoom():Void
	{
		clear();
		add(currentRoom.floor);
		add(currentRoom.walls);
		add(currentRoom.exitDoor);
		
		player = new Player(currentRoom.entrance.x, currentRoom.entrance.y);
		add(player);
	}
}
