package tl;

/*
 * frame count, "2" is important for Key.isDown/isPressed/isReleased
 */
@:native("tlfc") var frames(default, null) = 2;

/*
 * IMPORTANT : delta time measured in milliseconds
 */
class Timer {

	// fixed delta time
	public static inline var FIXED_DT = 1000. / WANTED_FPS;

	static var then : Float;

	static var id = -1;

	static var running : (dt : Float)->Void;

	static function update( now : Float ) {
		id = window.requestAnimationFrame(update);
		var elapsed = now - then;
	#if !FPS60 // soft fps limits
		if (elapsed < (1000. / 50.))
			return;
	#end
		frames++;
		then = now;
		running(elapsed);
	}

	public static function start( loop : Float->Void ) {
		running = loop;
		resume();
	}

	public static function resume() {
		stop();
		var now = performance.now();
		then = now - FIXED_DT;
		update(now);
	}

	public static inline function pause() {
		stop();
	}

	public static inline function stop() {
		window.cancelAnimationFrame(id);
	}
}
