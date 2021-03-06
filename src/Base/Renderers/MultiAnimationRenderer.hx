class MutiAnimationRenderer implements IRenderer
{
    private var renderer : h2d.Anim;
    private var animations : AnimationMap;
    private var baseSize : Int;
    private var playing : String;
    public var lockAnimation : Bool = false;
    public var flipX : Bool;
    public var flipY : Bool;
    public var onAnimationEnd(null, set) : () -> Void;
    public function set_onAnimationEnd(value : () -> Void) : () -> Void
    {
        return renderer.onAnimEnd = value;
    }
    public var loop(null, set) : Bool;
    public function set_loop(value : Bool) : Bool
    {
        return renderer.loop = value;
    }
    public var alpha(null, set) : Float;
    public function set_alpha(value : Float) : Float
    {
        return renderer.alpha = value;
    }

    public function new(animations : AnimationMap, animationSize : Int, initAnimation : String = null, speed : Float = 10)
    {
        this.animations = animations;
        renderer = new h2d.Anim(null, speed, Main.entityLayer);
        baseSize = animationSize;
        if ((playing = initAnimation) != null)
        {
            renderer.play(animations[initAnimation]);
        }
    }

    public static function newSingleAnimation(source : hxd.res.Image, size : Int = 32, speed : Float = 10)
    {
        var map = new AnimationMap();
        map.addToMap(source, "1", size);
        return new MutiAnimationRenderer(map, size, "1", speed);
    }

	public function init(entity:Entity) {}

	public function dispose()
    {
        renderer.remove();
    }

	public function render(pos:Vector, size:Vector)
    {
        renderer.x = pos.x + (flipX ? size.x : 0);
        renderer.y = pos.y + (flipY ? size.y : 0);
        renderer.scaleX = size.x / baseSize * (flipX ? -1 : 1);
        renderer.scaleY = size.y / baseSize * (flipY ? -1 : 1);
    }

    public function play(name : String)
    {
        if (playing == name || lockAnimation)
        {
            return;
        }
        renderer.play(animations[playing = name]);
    }
}