import hxd.Rand;
import MultiAnimationRenderer.MutiAnimationRenderer;

class JumpingGoombaEnemy extends GoombaEnemy
{
    private var jumpForce : Float;
    private var minRate : Float;
    private var maxRate : Float;
    private var count : Float;
    private var rng : Rand;

    public function new(pos : Vector, size : Vector, renderer : MutiAnimationRenderer, direction : Int = 1, speed : Float = 2, jumpForce : Float = 5, minRate : Float = 1.5, maxRate : Float = 3)
    {
        super(pos, size, renderer, direction, speed);
        this.jumpForce = jumpForce;
        this.minRate = minRate;
        this.maxRate = maxRate;
        count = (maxRate + minRate) / 2;
        rng = Rand.create();
    }

    override function preUpdate(timeScale:Float)
    {
        super.preUpdate(timeScale);
        if (grounded)
        {
            count -= timeScale / Main.TARGET_FPS;
            if (count <= 0)
            {
                velocity.y = -jumpForce;
                var percent = rng.rand();
                count = minRate * percent + maxRate * (1 - percent);
            }
        }
    }
}