class MutiAnimationRenderer implements IRenderer
{
    private var renderer : h2d.Anim;
    private var animations : AnimationMap;
    private var baseSize : Int;
    private var playing : String;
    public var flipX : Bool;
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

	public function init(entity:Entity) {}

	public function dispose()
    {
        renderer.remove();
    }

	public function render(pos:Vector, size:Vector)
    {
        renderer.x = pos.x + (flipX ? size.x : 0);
        renderer.y = pos.y;
        renderer.scaleX = size.x / baseSize * (flipX ? -1 : 1);
        renderer.scaleY = size.y / baseSize;
    }

    public function play(name : String)
    {
        if (playing == name)
        {
            return;
        }
        renderer.play(animations[playing = name]);
    }
}