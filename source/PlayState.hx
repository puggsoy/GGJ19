package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.math.FlxRandom;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	private var player:Player = null;
	
	private static inline var ROOM_TYPE_AMOUNT:Int = 12;
	private static inline var NUM_OF_ROOMS:Int = 1;
	private var roomNum:Int = 0;
	
	private var homeRoom:HomeRoom = null;
	private var currentRoom:Room = null;
	private var roomTrophy:Trophy = null;
	
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
		
		if (roomTrophy != null && FlxG.overlap(player, roomTrophy))
		{
			player.pickup(roomTrophy);
			roomTrophy = null;
		}
		
		if (!player.isOnScreen())
		{
			leaveRoom();
		}
	}
	
	private function leaveRoom():Void
	{
		roomTrophy = null;
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
	
	private function loadHomeRoom():Void
	{
		if (homeRoom == null)
		{
			homeRoom = new HomeRoom('home');
			player = new Player(0, 0);
		}
		
		currentRoom = homeRoom;
		
		initializeRoom();
		
		if (player.item != null)
		{
			homeRoom.placeTrophy(player.drop());
		}
		
		add(homeRoom.trophies);
	}
	
	private function loadDungeonRoom():Void
	{
		var num:Int = new FlxRandom().int(0, ROOM_TYPE_AMOUNT - 1);
		
		var room:DungeonRoom = new DungeonRoom('lvl' + num);
		
		currentRoom = room;
		
		initializeRoom();
		
		roomTrophy = room.trophy;
		add(room.trophy);
	}
	
	private function initializeRoom():Void
	{
		clear();
		add(currentRoom.floor);
		add(currentRoom.walls);
		
		player.setPosition(currentRoom.entrance.x, currentRoom.entrance.y);
		add(player);
		if (player.item != null)
		{
			add(player.item);
		}
	}
}
