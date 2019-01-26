package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	private var player:Player = null;
	
	private static inline var ROOM_NUM:Int = 1;
	
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
	
	private function initializeRoom()
	{
		clear();
		add(currentRoom.floor);
		add(currentRoom.walls);
		add(currentRoom.exitDoor);
		
		player = new Player(currentRoom.entrance.x, currentRoom.entrance.y);
		add(player);
	}
}
