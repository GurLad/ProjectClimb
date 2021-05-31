class PhysicsEntity extends Entity
{
    private static var GRAVITY_SCALE(default, null) : Float = 9.81 / 60;

    public var velocity : Vector;
    public var useGravity : Bool = true;
    public var grounded : Bool;

    public function new(pos : Vector, size : Vector, ?renderer : IRenderer = null, ?velocity : Vector = null)
    {
        super(pos, size, renderer);
        this.velocity = velocity != null ? velocity.clone() : Vector.ZERO;
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
        grounded = false;
        // Collisions
        var dirX, dirY : Float;
        var xRect, yRect : Rectangle;
        xRect = rect.clone();
        xRect.topLeft += velocity.xVector * timeScale;
        yRect = rect.clone();
        yRect.topLeft += velocity.yVector * timeScale;
        // Tilemap collisions
        var sizeRatio = size.x / LDtkController.TRUE_TILE_SIZE;
        var xx : Float = xRect.centre.x;
        var yy : Float = yRect.centre.y;
        var cx : Int = Math.floor(xx / LDtkController.TRUE_TILE_SIZE);
        var xr : Float = (xx - cx * LDtkController.TRUE_TILE_SIZE) / LDtkController.TRUE_TILE_SIZE;
        var cy : Int = Math.floor(yy / LDtkController.TRUE_TILE_SIZE);
        var yr : Float = (yy - cy * LDtkController.TRUE_TILE_SIZE) / LDtkController.TRUE_TILE_SIZE;
        trace("c: (" + cx + ", " + cy + "), r: (" + xr + ", " + yr + "), t: (" + xx + ", " + yy + ")");
        if (velocity.x > 0 && xr >= 1 - sizeRatio / 2 && LDtkController.hasCollision(cx + 1, cy))
        {
            pos.x = (cx + 1 - sizeRatio / 2) * LDtkController.TRUE_TILE_SIZE;
            velocity.x = 0;
        }
        else if (velocity.x < 0 && xr <= sizeRatio / 2 && LDtkController.hasCollision(cx - 1, cy))
        {
            pos.x = (cx + sizeRatio / 2) * LDtkController.TRUE_TILE_SIZE;
            velocity.x = 0;
        }
        if (velocity.y > 0 && yr >= 1 - sizeRatio / 2 && LDtkController.hasCollision(cx, cy + 1))
        {
            pos.y = (cy + 1 - sizeRatio / 2) * LDtkController.TRUE_TILE_SIZE;
            velocity.y = 0;
            grounded = true;
        }
        else if (velocity.y < 0 && yr <= sizeRatio / 2 && LDtkController.hasCollision(cx, cy - 1))
        {
            pos.y = (cy + sizeRatio / 2) * LDtkController.TRUE_TILE_SIZE;
            velocity.y = 0;
        }
        // Entity collisions
        for (entity in Entity.entities)
        {
            if (entity != this)
            {
                dirX = xRect.overlapsX(entity.rect);
                dirY = yRect.overlapsY(entity.rect);
                if (dirX != 0 || dirY != 0)
                {
                    onCollide(entity);
                    if ((entity is PhysicsEntity))
                    {
                        cast(entity, PhysicsEntity).onCollide(this);
                    }
                    // else
                    // {
                    //     // trace(velocity);
                    //     // trace(xRect.bottomRight);
                    //     // trace(yRect.bottomRight);
                    //     // trace(entity.rect.topRight);
                    //     // trace(dirX + ", " + dirY);
                    //     if (dirX > 0)
                    //     {
                    //         pos.x = entity.rect.bottomRight.x + size.x / 2 + 0.01;
                    //         velocity.x = 0;
                    //     }
                    //     else if (dirX < 0)
                    //     {
                    //         pos.x = entity.rect.topLeft.x - size.x / 2 - 0.01;
                    //         velocity.x = 0;
                    //     }
                    //     if (dirY < 0)
                    //     {
                    //         pos.y = entity.rect.bottomRight.y + size.y / 2 + 0.01;
                    //         velocity.y = 0;
                    //     }
                    //     else if (dirY > 0)
                    //     {
                    //         pos.y = entity.rect.topLeft.y - size.y / 2 - 0.01;
                    //         velocity.y = 0;
                    //         grounded = true;
                    //     }
                    // }
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