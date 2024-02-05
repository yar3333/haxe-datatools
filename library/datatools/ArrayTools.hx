package datatools;

class ArrayTools
{
	public static function equ<Z, T:{ function equ(e:Z) : Bool; }>(a:ArrayRO<T>, b:ArrayRO<T>) : Bool
	{
		if (a.length != b.length) return false;
		for (i in 0...a.length)
		{
			if (a[i] == null && b[i] != null) return false;
			if (a[i] != null && b[i] == null) return false;
			if (a[i] != null && !a[i].equ(cast b[i])) return false;
		}
		return true;
	}

	public static function equByFunc<T>(a:ArrayRO<T>, b:ArrayRO<T>, equFunc:T->T->Bool) : Bool
	{
		if (a.length != b.length) return false;
		for (i in 0...a.length)
		{
			if (a[i] == null && b[i] != null) return false;
			if (a[i] != null && b[i] == null) return false;
			if (a[i] != null && !equFunc(a[i], b[i])) return false;
		}
		return true;
	}

	public static function clone<Z, T:{ function clone() : Z; }>(array:ArrayRO<T>) : Array<T>
	{
		var r = new Array<T>();
		for (item in array)
		{
			r.push(cast item.clone());
		}
		return r;
	}
	
	public static function swap<Z>(arr:Array<Z>, i:Int, j:Int) : Void
	{
		var z = arr[i];
		arr[i] = arr[j];
		arr[j] = z;
	}
	
	public static function equFast<T>(a:ArrayRO<T>, b:ArrayRO<T>) : Bool
	{
		if (a.length != b.length) return false;
		for (i in 0...a.length)
		{
			if (a[i] != b[i]) return false;
		}
		return true;
	}
	
	public static function appendUniqueFast<T>(accum:Array<T>, items:ArrayRO<T>) : Array<T>
	{
		for (item in items)
		{
			if (accum.indexOf(item) < 0) accum.push(item);
		}
		return accum;
	}
}