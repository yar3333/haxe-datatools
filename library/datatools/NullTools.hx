package datatools;

private typedef Clonable<T> =
{
	function clone() : T;
}

private typedef Equable<T> =
{
	function equ(v:T) : Bool;
}

class NullTools
{
	public static function clone<Z, T:Clonable<Z>>(v:T) : T
	{
		return v != null ? (cast v.clone() : T) : null;
	}
	
	public static function equ<Z, T:Equable<Z>>(a:T, b:Z) : Bool
	{
		return a == null && b == null || a != null && b != null && a.equ(b);
	}
}