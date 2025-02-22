package tl;

/*
 * It's a seeded random number generator,
 * That allows to get always the same results starting from a given seed.
 */
class Rand {

	var seed1 : Int;
	var seed2 : Int;

	public function new( seed : Int ) {
		init(seed);
	}

	/*
	 *	Initialize the random generator with a seed.
	 */
	public function init( seed : Int ) {
		seed1 = seed;
		seed2 = hash(seed, 5381);
		if( seed1 == 0 ) seed1 = 1;
		if( seed2 == 0 ) seed2 = 1;
	}

	/*
	 * Return a random integer between 0 and n (excluded).
	 */
	public inline function random( n ) {
		return uint() % n;
	}

	/*
	 * Return a random float between 0.0 and 1.0 (excluded)
	 */
	public inline function rand() {
		// we can't use a divider > 16807 or else two consecutive seeds
		// might generate a similar float
		return (uint() % 10007) / 10007.0;
	}

	/*
	 * Return a random float between -scale and +scale (excluded)
	 */
	public inline function srand( scale = 1.0 ) {
		return ((int() % 10007) / 10007.0) * scale;
	}

	// this is two Marsaglia Multiple-with-Carry (MWC) generators combined
	function int() : Int {
		seed1 = cast 36969 * (seed1 & 0xFFFF) + (seed1 >> 16);
		seed2 = cast 18000 * (seed2 & 0xFFFF) + (seed2 >> 16);
		return (seed1 << 16) + seed2;
	}

	inline function uint() {
		return int() & 0x3FFFFFFF;
	}

	/*
	 *	Shuffle values of an array.
	 */
	public function shuffle<T>( a : Array<T> ) {
		var len = a.length;
		for(i in 0...len) {
			var x = random(len);
			var y = random(len);
			var tmp = a[x];
			a[x] = a[y];
			a[y] = tmp;
		}
	}

	public static function hash( n : Int, h : Int ) : Int {
		n *= 0xcc9e2d51;
		n = (n << 15) | (n >>> 17);
		n *= 0x1b873593;
		h ^= n;
		h = (h << 13) | (h >>> 19);
		h = h*5 + 0xe6546b64;
		h ^= h >> 16;
		h *= 0x85ebca6b;
		h ^= h >> 13;
		h *= 0xc2b2ae35;
		h ^= h >> 16;
		return h;
	}

	public static inline function create() {
		return new Rand(Std.int(Math.random() * 0x7FFFFFFF));
	}
}
