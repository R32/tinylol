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

	dynamic public static function onkeydown( e : KeyboardEvent ) {
		e.stopPropagation();
		var code = e.keyCode;
		if (pressed[code] > 0)
			return;
		pressed[code] = curFrame();
	}

	dynamic public static function onkeyup( e : KeyboardEvent ) {
		e.stopPropagation();
		pressed[e.keyCode] = -curFrame();
	}

	dynamic public static function init( ?capture : Bool ) {
		window.addEventListener("keydown", onkeydown, capture);
		window.addEventListener("keyup", onkeyup, capture);
	}
}
