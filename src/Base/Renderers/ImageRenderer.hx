class ImageRenderer extends ObjectRenderer
{
    private var bitmap : h2d.Bitmap;

    public function new(pos : Vector, sizeMod : Int, trueSize : Vector, image : hxd.res.Image)
    {
        super();
        x = pos.x;
        y = pos.y;
        addChild(bitmap = new h2d.Bitmap(image.toTile(), Main.entityLayer));
        bitmap.scaleX = sizeMod / trueSize.x;
        bitmap.scaleY = sizeMod / trueSize.y;
    }
}