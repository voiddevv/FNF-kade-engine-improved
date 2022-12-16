package;

import flixel.util.FlxTimer;
import scripting.Hscript;
import flixel.FlxSprite;

class Character extends FlxSprite
{
	public var script = new Hscript();
	public var curCharacter:String = '';
	public var canDance:Bool = true;
	public var danceSteps:Array<String> = ["idle"];
	public var curDance:Int = 0;
	public var holdTimer:Float = 0.0;
	public var debugMode:Bool = false;
	public var animOffsets:Map<String, Array<Dynamic>> = [];

	public function new(x:Float, y:Float, character:String, flipx:Bool = false)
	{
		this.x = x;
		this.y = y;
		this.flipX = flipx;
		this.antialiasing = true;
		super(x, y);
		this.curCharacter = character;
		script.interp.scriptObject = this;
		try
		{
			script.loadScript('images/characters/$curCharacter/character');
		}
		catch (e)
		{
			FlxG.log.error(e);
		}
		script.call("new");
		dance();
	}

	public function playAnim(anim:String, force:Bool = false, time:Float = 0.0)
	{
		var daOffset = animOffsets.get(anim);
		if (animOffsets.exists(anim))
		{
			offset.set(daOffset[0], daOffset[1]);
		}

		if (time > 0.0)
			canDance = false;
		new FlxTimer().start(time, function(tim)
		{
			canDance = true;
		});
		animation.play(anim, force);
	}

	public function dance()
	{
		playAnim(danceSteps[curDance]);
		curDance ++;
		if(curDance > danceSteps.length -1)
			curDance = 0;
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
