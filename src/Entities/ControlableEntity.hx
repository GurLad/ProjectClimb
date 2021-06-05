import hxd.Math;
import MultiAnimationRenderer.MutiAnimationRenderer;
import hxd.Key;

class ControlableEntity extends BaseHealthEntity
{
    private static var MOVEMENT_LERP_VALUE(default, never) : Float = 0.2; // No idea how to call this
    public var speed : Float;
    public var jumpForce : Float;
    private var direction : Int = 1;

    public function new(pos : Vector, size : Vector, renderer : MutiAnimationRenderer, speed : Float, jumpForce : Float)
    {
        super(pos, size, renderer);
        this.speed = speed;
        this.jumpForce = jumpForce;
    }

    override function get_tags():EntityType
    {
        return EntityType.Player;
    }

    public override function preUpdate(timeScale:Float)
    {
        super.preUpdate(timeScale);
        if (Key.isDown(Key.LEFT))
        {
            velocity.x = Math.lerp(velocity.x, -speed, MOVEMENT_LERP_VALUE * timeScale);
            //animation.play("Walk");
            animation.flipX = false;
            direction = -1;
        }
        else if (Key.isDown(Key.RIGHT))
        {
            velocity.x = Math.lerp(velocity.x, speed, MOVEMENT_LERP_VALUE * timeScale);
            //animation.play("Walk");
            animation.flipX = true;
            direction = 1;
        }
        else
        {
            var previousVelocity = velocity.x;
            velocity.x = Math.lerp(velocity.x, 0, MOVEMENT_LERP_VALUE * timeScale);
            if (previousVelocity * velocity.x < 0) // Passed target
            {
                velocity.x = 0;
            }
            animation.play("Idle");
        }
        if (Key.isPressed(Key.UP) && grounded) // Normal
        {
            velocity.y = -jumpForce;
        }
        if (Key.isPressed(Key.SPACE)) // Cheat
        {
            velocity.y = -jumpForce;
            new TempPlayerFireball(pos + size.xVector * direction, new Vector(5,5), new ColorRenderer(0xFF0000), new Vector(speed * direction, 0) * 2);
        }
    }

    override function onCollide(collider:Entity) {
        super.onCollide(collider);
    }
}