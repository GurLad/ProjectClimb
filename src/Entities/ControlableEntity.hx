import hxd.Key;

class ControlableEntity extends PhysicsEntity
{
    public var speed : Float;
    public var jumpForce : Float;

    public function new(pos : Vector, size : Vector, renderer : IRenderer, speed : Float, jumpForce : Float)
    {
        super(pos, size, renderer);
        this.speed = speed;
        this.jumpForce = jumpForce;
    }

    public override function preUpdate(timeScale:Float)
    {
        super.preUpdate(timeScale);
        if (Key.isDown(Key.LEFT))
        {
            velocity.x = -speed;
        }
        else if (Key.isDown(Key.RIGHT))
        {
            velocity.x = speed;
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
            size -= new Vector(5,5);
        }
    }

    override function onCollide(collider:Entity) {
        super.onCollide(collider);
        if (collider is PhysicsEntity)
        {
            collider.destroy();
        }
    }
}