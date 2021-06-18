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
        map.addToMap(hxd.Res.SnailEnemyFly, "Walk");
        return new FlyingGoombaEnemy(pos, new Vector(64, 64), new MutiAnimationRenderer(map, 32, "Walk"), faceRight ? 1 : -1);
    }
    
    public static function newBossSnail(pos : Vector, faceRight : Bool) : GoombaEnemy
    {
        var map = new AnimationMap();
        map.addToMap(hxd.Res.SnailEnemyWalk, "Walk");
        var boss = new GoombaEnemy(pos, new Vector(128, 128), new MutiAnimationRenderer(map, 32, "Walk"), faceRight ? 1 : -1, 4);
        boss.health = 10;
        boss.isBoss = true;
        new UILifebar(boss, LDtkController.levelSize.xVector * LDtkController.TRUE_TILE_SIZE + new Vector(16, 64 + 96 * 2), hxd.Res.BossHeartFull);
        return boss;
    }
}