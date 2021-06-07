import hxd.Key;

class Input
{
    // TBA: Add key binding
    public static function getLeft(player : Int) : Bool
    {
        return Key.isDown(player == 0 ? Key.LEFT : Key.A);
    }
    
    public static function getRight(player : Int) : Bool
    {
        return Key.isDown(player == 0 ? Key.RIGHT : Key.D);
    }
    
    public static function getHop(player : Int) : Bool
    {
        return Key.isPressed(player == 0 ? Key.UP : Key.W);
    }
    
    public static function getJump(player : Int) : Bool
    {
        return Key.isPressed(player == 0 ? Key.NUMPAD_4 : Key.Q);
    }
    
    public static function getCast(player : Int) : Bool
    {
        return Key.isPressed(player == 0 ? Key.NUMPAD_8 : Key.E);
    }
}