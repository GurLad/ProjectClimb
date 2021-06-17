import MultiAnimationRenderer.MutiAnimationRenderer;

class FlyingGoombaEnemy extends GoombaEnemy
{
    private var time : Float;
    private var flySpeed : Float;
    private var flyStrength : Float;

    override public function new(pos : Vector, size : Vector, renderer : MutiAnimationRenderer, direction : Int = 1, speed : Float = 2, flySpeed : Float = 5, flyStrength : Float = 1)
    {
        super(pos, size, renderer, direction, speed);
        this.flySpeed = flySpeed;
        this.flyStrength = flyStrength;
        useGravity = false;
    }

    override function preUpdate(timeScale:Float)
    {
        super.preUpdate(timeScale);
        time += timeScale / Main.TARGET_FPS;
        velocity.y = Math.cos(time * flySpeed) * flyStrength;
    }
}