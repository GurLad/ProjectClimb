import hxd.Key;

class ControlableEntity extends BaseHealthEntity
{
    public var speed : Float;
    public var jumpForce : Float;
    private var direction : Int = 1;

    public function new(pos : Vector, size : Vector, renderer : IRenderer, speed : Float, jumpForce : Float)
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
            velocity.x = -speed;
            direction = -1;
        }
        else if (Key.isDown(Key.RIGHT))
        {
            velocity.x = speed;
            direction = 1;
        }
        else
        {
            velocity.x = 0;
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