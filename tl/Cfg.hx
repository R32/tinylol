package tl;

/*
 * defines :
 *   `-D window-size=640x480`
 *   `-D FPS60`
 */
#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
#else
@:build(tl.Cfg.build())
#end
class Cfg {

	public static inline var WIDTH = 640;

	public static inline var HEIGHT = 480;

	// wanted FPS
	public static inline var WANTED_FPS = #if FPS60 60. #else 30. #end;

#if macro
	public static function build() {
		if (Context.defined("display"))
			return null;
		var size = Context.definedValue("window-size");
		if (size == null)
			return null;
		var a = size.split("x");
		var width = Std.parseInt(a[0]) ?? 640;
		var height = Std.parseInt(a[1]) ?? 480;
		var fields = Context.getBuildFields();
		Lambda.find(fields, f -> f.name == "WIDTH")?.kind = FVar(null, macro $v{width});
		Lambda.find(fields, f -> f.name == "HEIGHT")?.kind = FVar(null, macro $v{height});
		return fields;
	}
#end
}
