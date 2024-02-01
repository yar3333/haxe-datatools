package datatools;

@:dce
@:forward(length, iterator, indexOf, lastIndexOf, join, slice, filter, map, concat, copy, toString)
abstract ArrayRO<T>(std.Array<T>) from std.Array<T>
{
	@:arrayAccess inline function get(n:Int) return this[n];
	
	public inline function exists(f:T->Bool) return Lambda.exists(this, f);
	public inline function foreach(f:T->Bool) return Lambda.foreach(this, f);
	
	public function findIndex(f:T->Bool)
	{
		var n = 0;
		for (item in this)
		{
			if (f(item)) return n;
			n++;
		}
		return -1;
	}
	
	public function findLastIndex(f:T->Bool)
	{
		var n = this.length - 1;
		while (n >= 0)
		{
			if (f(this[n])) return n;
			n--;
		}
		return -1;
	}
    
    @:from static inline function fromDerived<T, D:T>(arr:ArrayRO<D>) return (cast arr : ArrayRO<T>);
}
