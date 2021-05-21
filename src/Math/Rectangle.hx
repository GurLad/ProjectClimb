class Rectangle
{
    public var topLeft : Vector;
    public var size : Vector;

    public var centre(get,set) : Vector;
    function get_centre()
    {
        return topLeft + (size / 2);
    }
    function set_centre(value : Vector)
    {
        return topLeft = value - (size / 2);
    }

    public var bottomRight(get,set) : Vector;
    function get_bottomRight()
    {
        return topLeft + size;
    }
    function set_bottomRight(value : Vector)
    {
        return topLeft = value - size;
    }

    public function new(x : Float, y : Float, width : Float, height : Float)
    {
        size = new Vector(width, height);
        centre = new Vector(x, y);
    }

    public static function fromCentreAndSize(centre : Vector, size : Vector)
    {
        return new Rectangle(centre.x, centre.y, size.x, size.y);
    }

    public function overlaps(other : Rectangle)
    {
        return (topLeft.x <= other.bottomRight.x || bottomRight.x >= other.topLeft.x) && (topLeft.y >= other.bottomRight.y || bottomRight.y <= other.topLeft.y);
    }

    // public function new(topLeft : Vector, size : Vector)
    // {
    //     this.topLeft = topLeft;
    //     this.size = size;
    // }
}