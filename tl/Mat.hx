package tl;

/*
 * Math
 */
class Mat {

	public static inline var PI = 3.14159265358979323;

	public static inline function abs( f : Float ) {
		return f < 0 ? -f : f;
	}

	public static inline function max( a : Float, b : Float ) {
		return a < b ? b : a;
	}

	public static inline function min( a : Float, b : Float ) {
		return a > b ? b : a;
	}

	public static inline function iabs( i : Int ) {
		return i < 0 ? -i : i;
	}

	public static inline function imax( a : Int, b : Int ) {
		return a < b ? b : a;
	}

	public static inline function imin( a : Int, b : Int ) {
		return a > b ? b : a;
	}

	public static inline function iclamp( v : Int, min : Int, max : Int ) {
		return v < min ? min : (v > max ? max : v);
	}

	public static inline function clamp( f : Float, min = 0., max = 1. ) {
		return f < min ? min : f > max ? max : f;
	}

	/*
	 * Linear interpolation between two values. When k is 0 a is returned, when it's 1, b is returned.
	 */
	public inline static function lerp( a : Float, b : Float, k : Float ) {
		return a + k * (b - a);
	}

	public static inline function toFixed( f : Float, c : Int ) : Float {
		return (f : Dynamic).toFixed(c);
	}

	/*
	 * takes an int , masks it and devide so that it safely maps 0...255 to 0...1.0
	 * @paramv an int between 0 and 255 will be masked
	 * @return a float between( 0 and 1)
	 */
	public static inline function b2f( v : Int ) : Float {
		return (v & 0xFF) * 0.0039215686274509803921568627451;
	}

	public static inline function swapBR(v) {
		return (v & 0xFF00FF00) | ((v << 16) & 0xFF0000) | ((v >> 16) & 0xFF);
	}

	public static inline function isPOT( v : Int ) : Bool {
		return (v & (v - 1)) == 0;
	}

	public static function nextPOT( v : Int ) : Int {
		--v;
		v |= v >> 1;
		v |= v >> 2;
		v |= v >> 4;
		v |= v >> 8;
		v |= v >> 16;
		return ++v;
	}

	public static function bitCount( v : Int ) {
		v = v - ((v >> 1) & 0x55555555);
		v = (v & 0x33333333) + ((v >> 2) & 0x33333333);
		return (((v + (v >> 4)) & 0x0F0F0F0F) * 0x01010101) >> 24;
	}
}
