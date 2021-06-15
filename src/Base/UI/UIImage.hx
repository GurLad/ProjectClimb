class UIImage extends IUI
{
    private var bitmap : h2d.Bitmap;

    public function new(pos : Vector, sizeMod : Int, image : hxd.res.Image)
    {
        super();
        x = pos.x;
        y = pos.y;
        scaleX = sizeMod;
        scaleY = sizeMod;
        addChild(bitmap = new h2d.Bitmap(image.toTile(), Main.uiLayer));
    }

    public function setImage(image : hxd.res.Image)
    {
        // This is a very bad workaround
        bitmap.remove();
        addChild(bitmap = new h2d.Bitmap(image.toTile(), Main.uiLayer));
    }
}