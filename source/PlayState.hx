package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.math.FlxRandom;
import flixel.system.FlxAssets;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.text.Font;
import openfl.Assets;

class PlayState extends FlxState
{
	private var player:Player = null;
	
	private static inline var ROOM_TYPE_AMOUNT:Int = 16;
	private static inline var NUM_OF_ROOMS:Int = 1;
	private var roomNum:Int = 0;
	private var completedRooms:Array<Int> = null;
	
	private var homeRoom:HomeRoom = null;
	private var currentRoom:Room = null;
	private var roomTrophy:Trophy = null;
	
	private var title1:FlxText = null;
	private var title2:FlxText = null;
	
	private var dotext:Bool = false;
	
	override public function create():Void
	{
		super.create();
		
		FlxG.mouse.useSystemCursor = true;
		bgColor = FlxColor.BROWN;
		
		var font:Font = Assets.getFont('assets/fonts/FFFFORWA.TTF');
		title1 = new FlxText(0, 80, FlxG.width, 'DUNGEON');
		title1.setFormat('FFF Forward', 36, 0xFFbcccdc, FlxTextAlign.CENTER);
		
		title2 = new FlxText(0, 200, FlxG.width, 'HOARDER');
		title2.setFormat('FFF Forward', 36, 0xFFbcccdc, FlxTextAlign.CENTER);
		
		loadHomeRoom();
		
		add(title1);
		add(title2);
		
		//sound
		FlxG.sound.playMusic('assets/sounds/Dungeon Music.ogg');
		FlxG.sound.play('assets/sounds/Welcome.wav');
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		FlxG.collide(player, currentRoom.walls);
		FlxG.collide(player, currentRoom.arrowTraps);
		
		if (currentRoom == homeRoom)
		{
			FlxG.collide(player, homeRoom.trophies);
		}
		
		if (FlxG.overlap(player, currentRoom.spikes))
		{
			killPlayer();
		}
		
		for (a in currentRoom.allArrows)
		{
			if (!a.isOnScreen())
			{
				a.destroy();
				currentRoom.allArrows.remove(a, true);
			}
			else
			if (FlxG.pixelPerfectOverlap(player, a))
			{
				killPlayer();
			}
		}
		
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
	
	private function killPlayer()
	{
		FlxG.sound.play('assets/sounds/Death.wav');
		roomNum = 0;
		player.drop();
		loadHomeRoom();
	}
	
	private function leaveRoom():Void
	{
		dotext = true;
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
		
		var newItem:Bool = false;
		if (player.item != null)
		{
			homeRoom.placeTrophy(player.drop());
			newItem = true;
		}
		
		add(homeRoom.trophies);
		
		if (dotext && newItem)
		{
			var alltext:Array<String> = Assets.getText('assets/data/Home Room Lines.txt').split('\r\n');
			var towrite:String = alltext[homeRoom.trophies.length - 1];
			
			var font:Font = Assets.getFont('assets/fonts/FFFFORWA.TTF');
			var t = new FlxText(0, FlxG.height - 50, FlxG.width, towrite);
			t.setFormat('FFF Forward', 12, 0xFFbcccdc, FlxTextAlign.CENTER);
			add(t);
		}
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
		if (roomTrophy != null) roomTrophy.destroy();
		roomTrophy = null;
		add(currentRoom.floor);
		add(currentRoom.walls);
		add(currentRoom.spikes);
		add(currentRoom.arrowTraps);
		add(currentRoom.allArrows);
		
		player.setPosition(currentRoom.entrance.x, currentRoom.entrance.y);
		add(player);
		if (player.item != null)
		{
			add(player.item);
		}
	}
}
