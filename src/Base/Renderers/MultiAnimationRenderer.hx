class MutiAnimationRenderer implements IRenderer
{
    private var renderer : h2d.Anim;
    private var animations : Map<String, Array<h2d.Tile>>;
    private var baseSize : Int;
    public var onAnimationEnd(null, set) : () -> Void;
    public function set_onAnimationEnd(value : () -> Void) : () -> Void
    {
        return renderer.onAnimEnd = value;
    }

    public function new(animations : Map<String, Array<h2d.Tile>>, animationSize : Int, initAnimation : String = null, speed : Float = 15)
    {
        this.animations = animations;
        renderer = new h2d.Anim(null, speed, Main.entityLayer);
        baseSize = animationSize;
        if (initAnimation != null)
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
        renderer.x = pos.x;
        renderer.y = pos.y;
        renderer.scaleX = size.x / baseSize;
        renderer.scaleY = size.y / baseSize;
    }

    public function play(name : String)
    {
        renderer.play(animations[name]);
    }
}