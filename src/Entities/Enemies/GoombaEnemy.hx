import MultiAnimationRenderer.MutiAnimationRenderer;

class GoombaEnemy extends BaseEnemy
{
    public var speed : Float = 2;
    private var direction : Int = 1;

    public function new(pos : Vector, size : Vector, renderer : MutiAnimationRenderer, speed : Float = 2)
    {
        super(pos, size, renderer);
        this.speed = speed;
    }

    override function preUpdate(timeScale:Float) {
        velocity.x = direction * speed;
        animation.flipX = direction > 0;
    }

    override function fixedUpdate(timeScale:Float) {
        if (velocity.x == 0)
        {
            direction *= -1;
        }
    }
}