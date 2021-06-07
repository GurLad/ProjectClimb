abstract AnimationMap(Map<String, Array<h2d.Tile>>) from Map<String, Array<h2d.Tile>> to Map<String, Array<h2d.Tile>>
{
    public inline function new()
    {
        this = new Map<String, Array<h2d.Tile>>();
    }

    public inline function addToMap(source : hxd.res.Image, name : String, size : Int = 32)
    {
        var tileSrc = source.toTile();
        var tiles = tileSrc.gridFlatten(size);
        this.set(name, tiles);
    }

    @:op([])
    public inline function arrayRead(s:String)
    {
        return this[s];
    }
}