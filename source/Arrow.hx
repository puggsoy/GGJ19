package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Arrow extends FlxSprite 
{
	private static inline var SPEED:Int = 2;
	
	private var dir:Direction = Direction.NONE;
	
	public function new(?X:Float=0, ?Y:Float=0, direction:Direction) 
	{
		super(X, Y);
		
		dir = direction;
		loadGraphic('assets/images/Arrow.png');
		
		switch (dir)
		{
			case Direction.UP:
				angle = 90;
			case Direction.LEFT:
				angle = 0;
			case Direction.RIGHT:
				angle = 180;
			case Direction.DOWN:
				angle = 270;
			default:
				throw('no direction, error?');
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		switch (dir)
		{
			case Direction.UP:
				y -= SPEED;
			case Direction.DOWN:
				y += SPEED;
			case Direction.LEFT:
				x -= SPEED;
			case Direction.RIGHT:
				x += SPEED;
			default:
				throw('no direction, error?');
		}
	}
}