package;

import flixel.system.FlxAssets.FlxGraphicAsset;

class DungeonRoom extends Room 
{
	public function new(path:String) 
	{
		super(path, 'assets/images/Dungeon Wall 1.png', 'assets/images/Dungeon Floor 1.png');
	}
}