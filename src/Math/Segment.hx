import haxe.Exception;

class Segment
{
    public var point1 : Vector;
    public var point2 : Vector;

    public function new(point1 : Vector, point2 : Vector)
    {
        this.point1 = point1.clone();
        this.point2 = point2.clone();
    }

    public function intersects(s : Segment) : Bool
    {
        if ((s.point1.x != s.point2.x && s.point1.y != s.point2.y) ||
            (point1.x != point2.x && point1.y != point2.y))
        {
            throw new Exception("Non-straight line - unsupported behaviour");
        }
        // Assume all lines are straight (x=a or y=a). Maybe switch to the algorithm here in the future: https://www.geeksforgeeks.org/check-if-two-given-line-segments-intersect/
        if (s.point1.x == s.point2.x)
        {
            if (point1.x == point2.x) // Parallel
            {
                return false;
            }
            else
            {
                return
                    s.point1.x <= Math.max(point1.x, point2.x) && s.point1.x >= Math.min(point1.x, point2.x) &&
                    point1.y <= Math.max(s.point1.y, s.point2.y) && point1.y >= Math.min(s.point1.y, s.point2.y);
            }
        }
        else if (point1.y == point2.y) // Parallel
        {
            return false;
        }
        else 
        {
            return s.intersects(this);
        }
        return true;
    }
}