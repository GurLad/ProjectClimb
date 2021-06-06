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
        return Key.isPressed(player == 0 ? Key.SPACE : Key.Q);
    }
}