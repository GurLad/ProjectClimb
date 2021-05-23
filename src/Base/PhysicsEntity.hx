class PhysicsEntity extends Entity
{
    private static var GRAVITY_SCALE(default, null) : Float = 9.81 / 60;

    public var velocity : Vector;
    public var useGravity : Bool = true;

    public function new(pos : Vector, size : Vector, ?renderer : IRenderer = null, ?velocity : Vector = null)
    {
        super(pos, size, renderer);
        this.velocity = velocity;
        if (this.velocity == null)
        {
            this.velocity = Vector.ZERO;
        }
    }

    public final override function update(timeScale:Float) {
        super.update(timeScale);
        // Before physics
        preUpdate(timeScale);
        // Physics - TBA: Change to only happen at ~30 FPS (to increase performance)
        if (useGravity)
        {
            velocity.y += GRAVITY_SCALE * timeScale;
        }
        // Collisions
        var dirX, dirY : Float;
        var xRect, yRect : Rectangle;
        xRect = rect.clone();
        xRect.topLeft += velocity.xVector;
        yRect = rect.clone();
        yRect.topLeft += velocity.yVector;
        for (entity in Entity.entities)
        {
            if (entity != this)
            {
                dirX = xRect.overlapsX(entity.rect);
                dirY = yRect.overlapsY(entity.rect);
                if (dirX != 0 || dirY != 0)
                {
                    onCollide(entity);
                    var temp : Rectangle = rect;
                    // trace(velocity);
                    // trace(xRect.bottomRight);
                    // trace(yRect.bottomRight);
                    // trace(entity.rect.topRight);
                    // trace(dirX + ", " + dirY);
                    if (dirX > 0)
                    {
                        temp.topLeft = new Vector(entity.rect.bottomRight.x + 0.01, temp.topLeft.y);
                        pos = temp.centre;
                        velocity.x = 0;
                    }
                    else if (dirX < 0)
                    {
                        temp.bottomRight = new Vector(entity.rect.topLeft.x - 0.01, temp.bottomRight.y);
                        pos = temp.centre;
                        velocity.x = 0;
                    }
                    if (dirY < 0)
                    {
                        temp.topLeft = new Vector(temp.topLeft.x, entity.rect.bottomRight.y + 0.01);
                        pos = temp.centre;
                        velocity.y = 0;
                    }
                    else if (dirY > 0)
                    {
                        temp.bottomRight = new Vector(temp.bottomRight.x, entity.rect.topLeft.y - 0.01);
                        pos = temp.centre;
                        velocity.y = 0;
                    }
                }
            }
        }
        pos += velocity * timeScale;
        // Post physics - only when they trigger
        fixedUpdate(timeScale);
    }

    public function preUpdate(timeScale:Float) {} // Abstract

    public function fixedUpdate(timeScale:Float) {} // Abstract

    public function onCollide(collider:Entity) {} // Abstract
}