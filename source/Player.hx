package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

class Player extends FlxSprite 
{
	private static inline var walkSpeed:Float = 2.5;
	private static inline var animSpeed:Int = 12;
	
	private var xSpeed:Float = 0;
	private var ySpeed:Float = 0;
	
	private var direction:Direction = DOWN;
	
	public var item(default, null):Trophy = null;
	
	private var dirStrings:Map<Direction, String> =
	[
	UP => 'up',
	DOWN => 'down',
	LEFT => 'left',
	RIGHT => 'right'
	];
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		loadGraphic('assets/images/runner1.png', true, 16, 16);
		animation.add('idle-up', [0], 0, false);
		animation.add('idle-down', [4], 0, false);
		animation.add('idle-left', [8], 0, false);
		animation.add('idle-right', [8], 0, false, true);
		animation.add('walk-up', [1, 2, 3, 0], animSpeed, true);
		animation.add('walk-down', [5, 6, 7, 4], animSpeed, true);
		animation.add('walk-left', [9, 10, 11, 8], animSpeed, true);
		animation.add('walk-right', [9, 10, 11, 8], animSpeed, true, true);
		
		animation.play('idle-down');
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		move();
		
		var dstring:String = dirStrings[direction];
		
		if (xSpeed != 0 || ySpeed != 0)
		{
			animation.play('walk-' + dstring);
		}
		else
		{
			animation.play('idle-' + dstring);
		}
		
		if (item != null)
		{
			item.setPosition(x, y - item.height + 2);
		}
	}
	
	private function move():Void
	{
		xSpeed = 0;
		ySpeed = 0;
		
		if (FlxG.keys.pressed.LEFT)
		{
			xSpeed = -walkSpeed;
			direction = LEFT;
		}
		else
		if (FlxG.keys.pressed.RIGHT)
		{
			xSpeed = walkSpeed;
			direction = RIGHT;
		}
		
		if (FlxG.keys.pressed.UP)
		{
			ySpeed = -walkSpeed;
			direction = UP;
		}
		else
		if (FlxG.keys.pressed.DOWN)
		{
			ySpeed = walkSpeed;
			direction = DOWN;
		}
		
		x += xSpeed;
		y += ySpeed;
	}
	
	public function pickup(trophy:Trophy):Void
	{
		item = trophy;
		item.carry();
	}
	
	public function drop():Trophy
	{
		item.drop();
		var ret:Trophy = item;
		item = null;
		return ret;
	}
}

enum Direction
{
	UP;
	DOWN;
	LEFT;
	RIGHT;
}