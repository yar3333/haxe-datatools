package datatools;

@:dce
@:forward(length, iterator, indexOf, lastIndexOf, join, slice, filter, map, concat, copy, toString)
abstract ArrayRO<T>(std.Array<T>) from std.Array<T>
{
	@:arrayAccess inline function get(n:Int) return this[n];
	
	public inline function exists(f:T->Bool) return Lambda.exists(this, f);
	public inline function foreach(f:T->Bool) return Lambda.foreach(this, f);
	
	public function findIndex(f:T->Bool) return stdlib.Lambda.LambdaIterable.findIndex(this, f);
	public function findLastIndex(f:T->Bool) return stdlib.Lambda.LambdaIterable.findLastIndex(this, f);
	
	public static function fromDerived<T, Z:T>(arr:ArrayRO<Z>) return (cast arr:ArrayRO<T>);
}
