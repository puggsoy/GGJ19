package;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxTimer;

class ArrowTrap extends FlxSprite
{
	private static inline var FIRE_RATE:Float = 1;
	
	private var dir:Direction = Direction.NONE;
	private var timer:FlxTimer = null;
	
	public var arrowGroup(default, null):FlxTypedGroup<Arrow> = null;
	
	public function new(?X:Float = 0, ?Y:Float = 0, direction:Direction, arrowGroup:FlxTypedGroup<Arrow>)
	{
		super(X, Y);
		
		this.arrowGroup = arrowGroup;
		dir = direction;
		loadGraphic('assets/images/Arrow Trap.png');
		
		switch (dir)
		{
			case Direction.UP:
				angle = 180;
			case Direction.LEFT:
				angle = 90;
			case Direction.RIGHT:
				angle = 270;
			case Direction.DOWN:
				angle = 0;
			default:
				throw('no direction, error?');
		}
		
		immovable = true;
		arrowGroup = new FlxTypedGroup<Arrow>();
		timer = new FlxTimer();
		timer.start(1, fire, 0);
	}
	
	private function fire(t:FlxTimer):Void
	{
		var pos:FlxPoint = switch (dir)
		{
			case Direction.UP:
				FlxPoint.get(x, y - height);
			case Direction.DOWN:
				FlxPoint.get(x, y + height);
			case Direction.LEFT:
				FlxPoint.get(x - width, y);
			case Direction.RIGHT:
				FlxPoint.get(x + width, y);
			default:
				throw('no direction, error?');
		}
		
		arrowGroup.add(new Arrow(pos.x, pos.y, dir));
	}
}