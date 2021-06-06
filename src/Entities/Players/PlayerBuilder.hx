import MultiAnimationRenderer.MutiAnimationRenderer;

class PlayerBuilder
{
    public static function newBlunk(playerID : Int, pos : Vector) : ControlableEntity
    {
        var tileSrc = hxd.Res.Idle.toTile();
        var tiles = tileSrc.gridFlatten(32);
        var map = new Map<String, Array<h2d.Tile>>();
        map.set("Idle", tiles);

        return new ControlableEntity(
            playerID,
            pos,
            new Vector(64,64),
            new MutiAnimationRenderer(map, 32, "Idle"),
            5, 5);
    }
}