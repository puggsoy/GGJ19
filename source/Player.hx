package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

class Player extends FlxSprite 
{
	private static inline var walkSpeed:Float = 1;
	
	private var xSpeed:Float = 0;
	private var ySpeed:Float = 0;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		makeGraphic(10, 10, FlxColor.CYAN);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		move();
	}
	
	private function move():Void
	{
		xSpeed = 0;
		ySpeed = 0;
		
		if (FlxG.keys.pressed.LEFT)
		{
			xSpeed = -walkSpeed;
		}
		else
		if (FlxG.keys.pressed.RIGHT)
		{
			xSpeed = walkSpeed;
		}
		
		if (FlxG.keys.pressed.UP)
		{
			ySpeed = -walkSpeed;
		}
		else
		if (FlxG.keys.pressed.DOWN)
		{
			ySpeed = walkSpeed;
		}
		
		x += xSpeed;
		y += ySpeed;
	}
}