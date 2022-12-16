import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;

class Paths {
	public static function getPath(path:String) {
		return 'assets/$path';
	}
	public static function image(file:String) {
		return getPath('images/$file.png');
	}
	public static function sound(file:String) {
		return getPath('sounds/$file.ogg');
	}
	public static function music(file:String) {
		return getPath('music/$file.ogg');
	}
	public static function font(file:String) {
		return getPath('fonts/$file');
	}
	public static function getScript(script:String) {
		return getPath('$script.hx');
	}
	public static function inst(song:String) {
		return getPath('songs/${song.toLowerCase()}/Inst.ogg');
	}
	public static function voices(song:String) {
		return getPath('songs/${song.toLowerCase()}/Voices.ogg');
	}
	public static function lua(script:String) {
		return getPath('data/$script.lua');
	}
	public static function getSparrowAtlas(file:String) {
		return FlxAtlasFrames.fromSparrow(image(file),getPath('images/$file.xml'));
	}
	public static function getPackerAtlas(file:String) {
		return FlxAtlasFrames.fromSpriteSheetPacker(image(file),getPath('images/$file.txt'));
	}
	public static function soundRandom(file:String,min:Int,max:Int) {
		return sound(file + FlxG.random.int(min,max));
	}
	public static function json(data:String) {
		return getPath('$data.json');
	}
	public static function getCharacter(type:String,character:String) {
		return getSparrowAtlas('characters/$character/character');
	}
}