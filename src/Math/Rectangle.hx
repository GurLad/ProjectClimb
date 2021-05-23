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

    public var bottomLeft(get,null) : Vector;
    function get_bottomLeft()
    {
        return topLeft + size - new Vector(size.x, 0);
    }

    public var topRight(get,null) : Vector;
    function get_topRight()
    {
        return topLeft + size - new Vector(0, size.y);
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

    public function clone() : Rectangle
    {
        return Rectangle.fromCentreAndSize(centre, size);
    }

    public function pointInRectangle(point : Vector) : Bool
    {
        return point.x >= topLeft.x && point.x <= bottomRight.x && point.y >= topLeft.y && point.y <= bottomRight.y;
    }
    // I'm not sure whether the current approach or using segment intersection is more efficient - TODO: check one day
    public function overlaps(other : Rectangle, ?checkedOther : Bool = false) : Bool
    {
        return other.pointInRectangle(topLeft) || other.pointInRectangle(topRight) || other.pointInRectangle(bottomLeft) || other.pointInRectangle(bottomRight) ||
            checkedOther ? false : other.overlaps(this, true);
    }
    // See above
    public function overlapsY(other : Rectangle, ?checkedOther : Bool = false) : Int
    {
        if (other.pointInRectangle(topLeft) || other.pointInRectangle(topRight))
        {
            trace(other.centre + " is above " + centre);
            return -1;
        }
        if (other.pointInRectangle(bottomRight) || other.pointInRectangle(bottomLeft))
        {
            trace(other.centre + " is below " + centre);
            return 1;
        }
        return checkedOther ? 0 : -other.overlapsY(this, true);
    }
    // See above
    public function overlapsX(other : Rectangle, ?checkedOther : Bool = false) : Int
    {
        if (other.pointInRectangle(topLeft) || other.pointInRectangle(bottomLeft))
        {
            return 1;
        }
        if (other.pointInRectangle(bottomRight) || other.pointInRectangle(topRight))
        {
            return -1;
        }
        return checkedOther ? 0 : -other.overlapsX(this, true);
    }

    // public function new(topLeft : Vector, size : Vector)
    // {
    //     this.topLeft = topLeft;
    //     this.size = size;
    // }
}