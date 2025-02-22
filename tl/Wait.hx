package tl;

private typedef Waiter = {
	var delay : Int; // in frames
	var ?extra : Dynamic;
	var run : haxe.Constraints.Function;
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
		list.resize(0);
	}

	public inline function addw( w : Waiter ) {
		list.push(w);
	}

	public inline function addx( delay : Int, run : Void->Void ) {
		list.push({ delay : delay, run : run });
	}

	public inline function add<T>( delay : Int, run : T->Void, extra : T ) {
		list.push({ delay : delay, run : run, extra : extra });
	}

	public function update() {
		var i = 0;
		while (i < list.length) {
			var w = list[i];
			w.delay--;
			if (w.delay <= 0) {
				w.run(w.extra);
				list.splice(i, 1);
			} else {
				i++;
			}
		}
	}
}
