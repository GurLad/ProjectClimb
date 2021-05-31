class ColorRenderer extends ObjectRenderer
{
    private var color : Int;

    public function new(color : Int)
    {
        super();
        this.color = color;
        addChild(new h2d.Bitmap(h2d.Tile.fromColor(color, 1, 1), Main.entityLayer));
    }
}