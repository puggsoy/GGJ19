package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

class Wall extends FlxSprite 
{
	public function new(?X:Float=0, ?Y:Float=0, graphic:FlxGraphicAsset) 
	{
		super(X, Y);
		
		loadGraphic(graphic, false);
		immovable = true;
	}
}