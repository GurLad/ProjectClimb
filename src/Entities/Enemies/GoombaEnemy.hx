import MultiAnimationRenderer.MutiAnimationRenderer;

class GoombaEnemy extends BaseEnemy
{
    public var speed : Float = 2;
    private var direction : Int = 1;

    public function new(pos : Vector, size : Vector, renderer : MutiAnimationRenderer, direction : Int = 1, speed : Float = 2)
    {
        super(pos, size, renderer);
        this.direction = direction;
        this.speed = speed;
        health = 1;
    }

    override function preUpdate(timeScale:Float)
    {
        super.preUpdate(timeScale);
        velocity.x = direction * speed;
        animation.flipX = direction > 0;
    }

    override function fixedUpdate(timeScale:Float)
    {
        super.preUpdate(timeScale);
        if (velocity.x == 0)
        {
            direction *= -1;
        }
    }
}