import MultiAnimationRenderer.MutiAnimationRenderer;

class EnemyBuilder
{
    public static function newSnail(pos : Vector, faceRight : Bool) : GoombaEnemy
    {
        var map = new AnimationMap();
        map.addToMap(hxd.Res.SnailEnemyWalk, "Walk");
        return new GoombaEnemy(pos, new Vector(64, 64), new MutiAnimationRenderer(map, 32, "Walk"), faceRight ? 1 : -1);
    }
    
    public static function newFlyingSnail(pos : Vector, faceRight : Bool) : GoombaEnemy
    {
        var map = new AnimationMap();
        map.addToMap(hxd.Res.SnailEnemyWalk, "Walk");
        return new FlyingGoombaEnemy(pos, new Vector(64, 64), new MutiAnimationRenderer(map, 32, "Walk"), faceRight ? 1 : -1);
    }
}