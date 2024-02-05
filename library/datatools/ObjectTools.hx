package datatools;

class ObjectTools
{
	public static function equFast<T:{}>(a:T, b:T) : Bool
	{
		var fieldsA = Reflect.fields(a);
		var fieldsB = Reflect.fields(b);
		if (fieldsA.length != fieldsB.length) return false;
		fieldsA.sort(cmpString);
		fieldsB.sort(cmpString);
		if (!ArrayTools.equFast(fieldsA, fieldsB)) return false;
        var valuesA = fieldsA.map(x -> Reflect.field(a, x));
        var valuesB = fieldsB.map(x -> Reflect.field(b, x));
		if (!ArrayTools.equFast(valuesA, valuesB)) return false;
		return true;
	}

    static function cmpString(a:String, b:String) : Int
    {
        if (a < b) return -1;
        if (a > b) return  1;
        return 0;
    }
}