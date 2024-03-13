package datatools;

@:dce
@:forward(length, iterator, indexOf, lastIndexOf, join, slice, filter, map, concat, copy, contains, toString)
abstract ArrayRO<T>(std.Array<T>) from std.Array<T>
{
	@:arrayAccess inline function get(n:Int) return this[n];
	
	public inline function exists(f:T->Bool) return Lambda.exists(this, f);
	public inline function find(f:T->Bool) return Lambda.find(this, f);
	public inline function findIndex(f:T->Bool) return Lambda.findIndex(this, f);
	public inline function flatMap<R>(f:(item:T) -> Iterable<R>) return Lambda.flatMap(this, f);
    public inline function fold<R>(f:(item:T, result:R) -> R, first:R) return Lambda.fold(this, f, first);
    public inline function foldi<R>(f:(item:T, result:R, index:Int) -> R, first:R) return Lambda.foldi(this, f, first);
	public inline function foreach(f:T->Bool) return Lambda.foreach(this, f);
	public inline function mapi<R>(f:(index:Int, item:T) -> R) return Lambda.mapi(this, f);
	
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

    public function filterByType<R>(klass:Class<R>) : Array<R>
    {
        return cast this.filter(x -> Std.isOfType(x, klass));
    }

    public function skipWhile(f:T->Bool) : Array<T>
    {
		var n = 0;
		while (n < this.length)
		{
			if (!f(this[n])) return this.slice(n);
			n++;
		}
		return [];
    }

    public function reversed() : Array<T>
    {
		final r = this.copy();
        r.reverse();
        return r;
    }
    
    @:from static inline function fromDerived<T, D:T>(arr:ArrayRO<D>) return (cast arr : ArrayRO<T>);
}
