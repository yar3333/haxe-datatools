package datatools;

using Lambda;

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
		return equCustom(a, b, function(e1, e2) return (e1 == null && e2 == null) || (e1 != null && e2 != null && e1.equ(cast e2)));
	}
	
	public static function equFast<K,V>(a:Map<K,V>, b:Map<K,V>) : Bool
	{
		return equCustom(a, b, function(e1, e2) return e1 == e2);
	}
	
	public static function equCustom<K,V>(a:Map<K,V>, b:Map<K,V>, cmp:V->V->Bool) : Bool
	{
		var keysA = a.keys().array();
		var keysB = b.keys().array();
		
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
}