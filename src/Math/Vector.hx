import hxd.Math;

private typedef BaseVector = {x:Float, y:Float}

@:forward
abstract Vector(BaseVector) from BaseVector to BaseVector
{
    public static var ZERO(default, never) : Vector = new Vector(0, 0);

    public var normalized(get, never) : Vector;
    function get_normalized()
    {
        var v : Vector = new Vector(this.x, this.y) / size;
        return v;
    }

    public var size(get, never) : Float;
    function get_size()
    {
        return new Vector(this.x, this.y).distance(ZERO);
    }

    public inline function new(x : Float, y : Float)
    {
        this = {x: x, y: y};
    }

    public function distance(v : Vector) : Float
    {
        return Math.sqrt(Math.pow(this.x - v.x, 2) + Math.pow(this.y - v.y, 2));
    }

    @:op(A * B)
    public inline function multiply(n : Float) : Vector
    {
        return new Vector(this.x * n, this.y * n);
    }

    @:op(A / B)
    public inline function divide(n : Float) : Vector
    {
        return new Vector(this.x / n, this.y / n);
    }

    @:op(A + B)
    public inline function add(v : Vector) : Vector
    {
        return new Vector(this.x + v.x, this.y + v.y);
    }

    @:op(A - B)
    public inline function sub(v : Vector) : Vector
    {
        return new Vector(this.x - v.x, this.y - v.y);
    }
}