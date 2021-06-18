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
        return Key.isDown(player == 0 ? Key.UP : Key.W);
    }
    
    public static function getJump(player : Int) : Bool
    {
        return Key.isPressed(player == 0 ? Key.NUMPAD_8 : Key.H);
    }
    
    public static function getCast(player : Int) : Bool
    {
        return Key.isPressed(player == 0 ? Key.NUMPAD_4 : Key.G);
    }
    
    private static function getDown(player : Int) : Bool // Useless
    {
        return Key.isDown(player == 0 ? Key.DOWN : Key.S);
    }
    
    public static function getAxisX(player : Int) : Int // Change to Float for controller support - until then, use Int
    {
        return getRight(player) ? 1 : (getLeft(player) ? -1 : 0);
    }
    
    public static function getAxisY(player : Int) : Int
    {
        return getDown(player) ? 1 : (getHop(player) ? -1 : 0);
    }
}