class ColorRenderer extends IRenderer
{
    private var color : Int;

    public function new(color : Int)
    {
        super(Main.entityLayer);
        this.color = color;
    }

    public override function init()
    {
        super.init();
        addChild(new h2d.Bitmap(h2d.Tile.fromColor(color, 1, 1), Main.entityLayer));
    }
}