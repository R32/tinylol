package tl;

#if macro
import haxe.macro.Expr;
import haxe.macro.Context;
 using haxe.macro.Tools;
#end

class Macros {
	macro public static function nbits(e) {
		var num = expected_int(e);
		return {expr : EConst(CInt( "" + tl.Mat.bitCount(num - 1))), pos : e.pos};
	}

	macro public static function swapBR(e) {
		try {
			var argb = expected_int(e, false);
			return macro @:pos(e.pos) $v{ tl.Mat.swapBR(argb) };
		} catch(_) {
			return macro @:pos(e.pos) tl.Mat.swapBR($e);
		}
	}
#if macro
	static function expected_int( e : ExprOf<Int>, fatal = true ) : Int {
		switch(e.expr) {
		case EConst(CInt(Std.parseInt(_) => i)):
			return i;
		case EConst(CIdent(_)):
			switch(Context.typeExpr(e).expr) {
			case TConst(TInt(i)):
				return i;
			default:
			}
		default:
		}
		if (fatal)
			Context.fatalError("UnExpected : " + e.toString(), e.pos);
		throw e;
	}
#end
}
