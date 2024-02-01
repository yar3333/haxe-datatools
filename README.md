# datatools haxe library #

Light library with a data structures stuff:

 * read-only arrays;
 * clone and compare support for `Array`;
 * clone and compare support for `Map`.

 ```haxe
 // ArrayRO - read-only arrays
 import datatools.ArrayRO;

class A {}
class B extends A {}

function main()
{
    var roA: ArrayRO<A> = [ new A() ]; // conversion from Array to ArrayRO with no explicit cast

    var arrB = new ArrayRO<B>();
    var arrA: ArrayRO<A> = arrB; // downcast conversion w/o explicit cast
}
```

```haxe
// Deep array comparison
import datatools.NullTools;
using datatools.ArrayTools;

class EquableItem
{
    var a: String;
    var b: Int;

    public function equ(x:EquableItem)
    {
        // don't test `x == null`, that doing automatically
        return a == x.a 
            && b == x.b;
    }
}

function main()
{
    var arr1: Array<EquableItem>;
    var arr2: Array<EquableItem>;

    if (arr1.equ(arr2))
    {
        ...
    }

    if (NullTools.equ(arr1, arr2)) // `arr1` and/or `arr2` can be null
    {
        ...
    }
 }
 ```

```haxe
// Deep array cloning
import datatools.NullTools;
using datatools.ArrayTools;

class ClonableItem
{
    var a: String;
    var b: Int;

    public function new(a:String, b:Int)
    { 
        this.a = a; 
        this.b = b; 
    }

    public function clone(): ClonableItem
    {
        return new ClonableItem(a, b);
    }
}

function main()
{
    var arr1: Array<ClonableItem> = [ new ClonableItem("test", 5) ];
    var arr2 = arr1.clone();

    var arr3 = NullTools.clone(arr1); // if arr1 == null => clone result is null
 }
 ```
