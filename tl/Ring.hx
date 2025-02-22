package tl;

/*
 * reference: https://github.com/torvalds/linux/blob/master/include/linux/circ_buf.h
 */
class Ring<T> {

	var head : Int;
	var tail : Int;
	var caps : Int;
	var data : haxe.ds.Vector<T>;

	public inline function count() return (head - tail) & caps;

	public inline function space() return (tail - head - 1) & caps;

	/*
	 * NOTE : Make sure the "len" is a power of 2.
	 */
	public function new( len : Int ) {
		caps = len - 1;
		data = new haxe.ds.Vector(caps + 1);
		reset();
	}

	public function reset() {
		head = 0;
		tail = 0;
	}

	public function push( v : T ) {
		if (space() == 0)
			tail = (tail + 1) & caps;
		data[head] = v;
		head = (head + 1) & caps;
	}

	public function unshift( v : T ) {
		if (space() == 0)
			head = (head - 1) & caps;
		tail = (tail - 1) & caps;
		data[tail] = v;
	}

	public function pop() : Null<T> {
		var ret : Null<T> = null;
		if (count() > 0) {
			head = (head - 1) & caps;
			ret = data[head];
		}
		return ret;
	}

	public function shift(): Null<T> {
		var ret:Null<T> = null;
		if (count() > 0) {
			ret = data[tail];
			tail = (tail + 1) & caps;
		}
		return ret;
	}
}
