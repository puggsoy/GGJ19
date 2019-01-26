package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class ExitDoor extends FlxSprite 
{
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		loadGraphic('assets/images/door 01.png', true, 16, 16);
		animation.add('idle', [2], 0, false);
	}
}