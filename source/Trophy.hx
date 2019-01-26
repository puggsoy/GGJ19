package;

import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Trophy extends FlxSprite 
{
	public var carrying(default, null):Bool = false;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		loadGraphic('assets/images/Trophies.png', true, 16, 16);
		var num:Int = new FlxRandom().int(0, Math.floor(graphic.width / 16) - 1);
		animation.add('idle', [num], 0, false);
		animation.play('idle');
		
		immovable = true;
	}
	
	public function carry():Void
	{
		solid = false;
		carrying = true;
	}
	
	public function drop():Void
	{
		solid = true;
		carrying = false;
	}
}