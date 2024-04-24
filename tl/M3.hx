package tl;

/*
 * matrix 3x3 in "column major order" for webgl
 *
 * 1, 0, 0, // (x)
 * 0, 1, 0, // (y)
 * 0, 0, 1, // (w)
 */
class M3 {

	/*
	 * convert pixels to clip space
	 */
	public static function proj( width : Float, height : Float ) : Array<Float> {
		return [
			2 / width, 0., 0.,
			0., -2 / height, 0.,
			-1., 1., 1.,
		];
	}

	public static function translate( tx : Float, ty : Float ) : Array<Float> {
		return [
			1., 0., 0.,
			0., 1., 0.,
			tx, ty, 1.,
		];
	}

	public static function rotate( radian : Float ) : Array<Float> {
		var c = Math.cos(radian);
		var s = Math.sin(radian);
		return [
			c , -s, 0.,
			s , c , 0.,
			0., 0., 1.
		];
	}

	public static function scale( sx : Float, sy : Float ) : Array<Float> {
		return [
			sx, 0., 0.,
			0., sy, 0.,
			0., 0., 1.
		];
	}

	/*
	 * TODO : wasm simd?
	 */
	public static function mul( a : Array<Float>, b : Array<Float> ) : Array<Float> {
		var a00 = a[0 * 3 + 0];
		var a01 = a[0 * 3 + 1];
		var a02 = a[0 * 3 + 2];
		var a10 = a[1 * 3 + 0];
		var a11 = a[1 * 3 + 1];
		var a12 = a[1 * 3 + 2];
		var a20 = a[2 * 3 + 0];
		var a21 = a[2 * 3 + 1];
		var a22 = a[2 * 3 + 2];

		var b00 = b[0 * 3 + 0];
		var b01 = b[0 * 3 + 1];
		var b02 = b[0 * 3 + 2];
		var b10 = b[1 * 3 + 0];
		var b11 = b[1 * 3 + 1];
		var b12 = b[1 * 3 + 2];
		var b20 = b[2 * 3 + 0];
		var b21 = b[2 * 3 + 1];
		var b22 = b[2 * 3 + 2];

		return [
			b00 * a00 + b01 * a10 + b02 * a20,
			b00 * a01 + b01 * a11 + b02 * a21,
			b00 * a02 + b01 * a12 + b02 * a22,
			b10 * a00 + b11 * a10 + b12 * a20,
			b10 * a01 + b11 * a11 + b12 * a21,
			b10 * a02 + b11 * a12 + b12 * a22,
			b20 * a00 + b21 * a10 + b22 * a20,
			b20 * a01 + b21 * a11 + b22 * a21,
			b20 * a02 + b21 * a12 + b22 * a22,
		];
	}
}
