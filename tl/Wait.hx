package tl;

/*
 * time measured in milliseconds
 */
private typedef Waiter = {
	var time : Float;
	function run() : Void;
}

class Wait {

	var list : Array<Waiter>;

	public function new() {
		list = [];
	}

	public inline function has() {
		return list.length > 0;
	}

	public inline function clear() {
		list = [];
	}

	public inline function add<T:Waiter>( w : T ) {
		list.push(w);
	}

	public inline function addeasy( time : Float, run : Void->Void ) {
		list.push({ time : time, run : run });
	}

	public function update( dt : Float ) {
		var i = list.length;
		while (i > 0) {
			var w = list[--i];
			w.time -= dt;
			if (w.time <= 0.) {
				w.run();
				list.splice(i, 1);
			}
		}
	}
}
