import hxd.System;
import hxd.Cursor;

class UIButton extends UIImage
{
    public function new(pos : Vector, sizeMod : Int, image : hxd.res.Image, onClick : () -> Void)
    {
        super(pos, sizeMod, image);
        var interaction = new h2d.Interactive(image.getSize().width, image.getSize().height, bitmap);
        interaction.onOver = function(event : hxd.Event) {
            bitmap.alpha = 0.7;
        }
        interaction.onOut = function(event : hxd.Event) {
            bitmap.alpha = 1;
        }
        interaction.onClick = function(event : hxd.Event) {
            onClick();
            System.setCursor(Cursor.Default);
        }
    }
}