import hxd.res.Image;
import hxd.System;
import hxd.Cursor;

class UIButton extends UIImage
{
    private static var font : hxd.res.BitmapFont;
    private var text : h2d.Text;
    private var interaction : h2d.Interactive;
    private var onClick : () -> Void;

    public function new(pos : Vector, sizeMod : Int, displayText : String, onClick : () -> Void)
    {
        if (font == null)
        {
            font = hxd.Res.Gaiden;
        }
        super(pos, sizeMod, hxd.Res.Button);
        this.onClick = onClick;
        text = new h2d.Text(font.toFont());
        text.scaleX = text.scaleY = sizeMod;
        text.textAlign = Center;
        text.setPosition(hxd.Res.Button.getSize().width / 2, 1);
        text.text = displayText;
        addChild(text);
        generateInteraction(hxd.Res.Button);
    }

    override function setImage(image : Image) {
        interaction.remove();
        super.setImage(image);
        generateInteraction(image);
    }

    private function generateInteraction(image : Image)
    {
        interaction = new h2d.Interactive(image.getSize().width, image.getSize().height, bitmap);
        interaction.onOver = function(event : hxd.Event)
        {
            bitmap.alpha = 0.7;
            text.alpha = 0.7;
        }
        interaction.onOut = function(event : hxd.Event)
        {
            bitmap.alpha = 1;
            text.alpha = 1;
        }
        interaction.onClick = function(event : hxd.Event)
        {
            onClick();
            System.setCursor(Cursor.Default);
        }
    }
}