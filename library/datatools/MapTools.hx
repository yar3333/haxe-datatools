package datatools;

class MapTools
{
	public static function clone<K,Z,V:{ function clone() : Z; }>(m:Map<K,V>) : Map<K,V>
	{
		var r : Map<K,V> = Type.createInstance(Type.getClass(m), []);
		
		for (k in m.keys())
		{
			r.set(k, cast m.get(k).clone());
		}
		
		return r;
	}
	
	public static function cloneFast<K,V>(m:Map<K,V>) : Map<K,V>
	{
		var r : Map<K,V> = Type.createInstance(Type.getClass(m), []);
		
		for (k in m.keys())
		{
			r.set(k, m.get(k));
		}
		
		return r;
	}
	
	public static function equ<K,Z,V:{ function equ(e:Z) : Bool; }>(a:Map<K,V>, b:Map<K,V>) : Bool
	{
		return equCustom(a, b, (e1, e2) -> (e1 == null && e2 == null) || (e1 != null && e2 != null && e1.equ(cast e2)));
	}
	
	public static function equFast<K,V>(a:Map<K,V>, b:Map<K,V>) : Bool
	{
		return equCustom(a, b, (e1, e2) -> e1 == e2);
	}
	
	public static function equCustom<K,V>(a:Map<K,V>, b:Map<K,V>, cmp:V->V->Bool) : Bool
	{
		var keysA = []; for (k in a.keys()) keysA.push(k);
		var keysB = []; for (k in b.keys()) keysB.push(k);
		
		if (keysA.length != keysB.length) return false;
		
		keysA.sort(Reflect.compare);
		keysB.sort(Reflect.compare);
		
		if (!ArrayTools.equFast(keysA, keysB)) return false;
		
		for (key in keysA)
		{
			if (!cmp(a.get(key), b.get(key))) return false;
		}
		
		return true;
	}
	
	public static function toObject<V>(map:Map<String, V>) : Dynamic<V>
	{
		var r = {};
		for (k in map.keys())
		{
			Reflect.setField(r, k, map.get(k));
		}
		return r;
	}
	
	public static function fromObject<V>(obj:Dynamic) : Map<String, V>
	{
		var r = new Map<String, V>();
		for (k in Reflect.fields(obj))
		{
			r.set(k, Reflect.field(obj, k));
		}
		return r;
	}
}