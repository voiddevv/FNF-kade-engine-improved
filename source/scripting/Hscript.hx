package scripting;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.system.FlxSound;
import flixel.math.FlxMath;
import hscript.Parser;
import hscript.Interp;
import StringTools;

class Hscript
{
	public var interp = new Interp();
	public var parser = new Parser();
	public var script:hscript.Expr;
	public var running:Bool = false;

	public function new()
	{
		parser.allowTypes = true;
		parser.allowJSON = true;
		parser.allowMetadata = true;
		interp.variables.set("Int", Int);
		interp.variables.set("String", String);
		interp.variables.set("Float", Float);
		interp.variables.set("Array", Array);
		interp.variables.set("Bool", Bool);
		interp.variables.set("Dynamic", Dynamic);
		interp.variables.set("Math", Math);
		interp.variables.set("Main", Main);
		interp.variables.set("FlxMath", FlxMath);
		interp.variables.set("Std", Std);
		interp.variables.set("StringTools", StringTools);
		interp.variables.set("FlxG",FlxG);
		interp.variables.set("FlxSound",FlxSound);
		interp.variables.set("FlxSprite",FlxSprite);
		interp.variables.set("FlxText",FlxText);
		interp.variables.set("FlxTween",FlxTween);
		interp.variables.set("Paths",Paths);
		interp.variables.set("CoolUtil",CoolUtil);
		running = true;
	}

	public function call(funcName:String, ?args:Array<Dynamic>):Dynamic {
        if(args == null) args = [];
        if(!running) return true;
        try {
            var func:Dynamic = interp.variables.get(funcName);
            if(func != null && Reflect.isFunction(func)) {
                if(args != null && args.length > 0)
                    return Reflect.callMethod(null, func, args);
                else
                    return func();
            }
        } catch(e) {
            FlxG.log.error(e.details());
        }
        return true;
    }
	public function loadScript(file:String)
	{
		script = parser.parseString(openfl.Assets.getText(Paths.getScript('$file')));
		interp.execute(script);
	}
}
