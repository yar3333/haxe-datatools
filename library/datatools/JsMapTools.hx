package datatools;

#if js

import js.lib.Map;
using js.lib.HaxeIterator;

class JsMapTools
{
	public static function clone<K,Z,V:{ function clone() : Z; }>(m:Map<K,V>) : Map<K,V>
	{
		var r : Map<K,V> = Type.createInstance(Type.getClass(m), []);
		
		for (kv in m.entries())
		{
			r.set(kv.key, cast kv.value.clone());
		}
		
		return r;
	}
	
	public static inline function cloneFast<K,V>(m:Map<K,V>) : Map<K,V> return new Map(m);
	
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
		if (a.size != b.size) return false;

        for (kv in a.entries())
        {
            if (!b.has(kv.key)) return false;
            if (!cmp(b.get(kv.key), kv.value)) return false;
        }
		
		return true;
	}
	
	public static function toObject<V>(map:Map<String, V>) : Dynamic<V>
	{
		var r = {};
		for (kv in map.entries())
		{
			Reflect.setField(r, kv.key, kv.value);
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

#end