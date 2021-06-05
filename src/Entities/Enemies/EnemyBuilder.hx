import MultiAnimationRenderer.MutiAnimationRenderer;

class EnemyBuilder
{
    public static function newSnail(pos : Vector) : GoombaEnemy
    {
        var tileSrc = hxd.Res.SnailEnemy.toTile();
        var tiles = tileSrc.gridFlatten(32);
        var map = new Map<String, Array<h2d.Tile>>();
        map.set("Walk", tiles);
        return new GoombaEnemy(pos, new Vector(64, 64), new MutiAnimationRenderer(map, 32, "Walk"));
    }
}