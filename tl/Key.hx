package tl;

@:native("tlkbd") final pressed = new Int32Array(256);

class Key {

	public static inline function isDown( code : Int ) {
		return pressed[code] > 0;
	}

	public static inline function isPressed( code : Int ) {
		return pressed[code] == curFrame() - 1;
	}

	public static inline function isReleased( code : Int ) {
		return pressed[code] == -curFrame() + 1;
	}

	public static inline function curFrame() return Timer.frames;

	public static function init() {
		var opt = {capture : true};
		window.addEventListener("keydown", function( e : KeyboardEvent ) {
			var code = e.keyCode;
			pressed[code] = curFrame();
			e.stopPropagation();
		}, opt);
		window.addEventListener("keyup", function( e : KeyboardEvent ) {
			var code = e.keyCode;
			pressed[code] = -curFrame();
			e.stopPropagation();
		}, opt);
	}
}
