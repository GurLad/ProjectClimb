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
        // --- New logic:
        // TODO: make Vector generic type, default Float, for Int vectors
        size -= new Vector(0.4, 0.4); // Bad fix for getting into tight corridors
        var sizeRatio : Float = size.x / LDtkController.TRUE_TILE_SIZE;
        var spPos : Float = 1 - sizeRatio / 2;
        var spNeg : Float = sizeRatio / 2;
        var oldCx : Int = Math.floor(rect.topLeft.x / LDtkController.TRUE_TILE_SIZE);
        var oldCy : Int = Math.floor(rect.topLeft.y / LDtkController.TRUE_TILE_SIZE);
        var oldTilesX : Int = Math.floor(rect.bottomRight.x / LDtkController.TRUE_TILE_SIZE) - Math.floor(rect.topLeft.x / LDtkController.TRUE_TILE_SIZE);
        var oldTilesY : Int = Math.floor(rect.bottomRight.y / LDtkController.TRUE_TILE_SIZE) - Math.floor(rect.topLeft.y / LDtkController.TRUE_TILE_SIZE);
        var newCx : Int = Math.floor(xRect.topLeft.x / LDtkController.TRUE_TILE_SIZE);
        var newCy : Int = Math.floor(yRect.topLeft.y / LDtkController.TRUE_TILE_SIZE);
        var newTilesX : Int = Math.floor(xRect.bottomRight.x / LDtkController.TRUE_TILE_SIZE) - Math.floor(xRect.topLeft.x / LDtkController.TRUE_TILE_SIZE);
        var newTilesY : Int = Math.floor(yRect.bottomRight.y / LDtkController.TRUE_TILE_SIZE) - Math.floor(yRect.topLeft.y / LDtkController.TRUE_TILE_SIZE);
        if (velocity.x > 0)
        {
            if (newCx + newTilesX > oldCx + oldTilesX)
            {
                for (i in 0...(oldTilesY + 1))
                {
                    if (LDtkController.hasCollision(newCx + newTilesX, oldCy + i))
                    {
                        pos.x = (oldCx + oldTilesX + spPos) * LDtkController.TRUE_TILE_SIZE - 0.01;
                        velocity.x = 0;
                    }
                }
            }
        }
        else if (velocity.x < 0)
        {
            if (newCx < oldCx)
            {
                for (i in 0...(oldTilesY + 1))
                {
                    if (LDtkController.hasCollision(newCx, oldCy + i))
                    {
                        pos.x = (oldCx + spNeg) * LDtkController.TRUE_TILE_SIZE + 0.01;
                        velocity.x = 0;
                    }
                }
            }
        }
        if (velocity.y > 0)
        {
            if (newCy + newTilesY > oldCy + oldTilesY)
            {
                for (i in 0...(oldTilesX + 1))
                {
                    if (LDtkController.hasCollision(oldCx + i, newCy + newTilesY))
                    {
                        pos.y = (oldCy + oldTilesY + spPos) * LDtkController.TRUE_TILE_SIZE - 0.01;
                        velocity.y = 0;
                        grounded = true;
                    }
                }
            }
        }
        else if (velocity.y < 0)
        {
            if (newCy < oldCy)
            {
                for (i in 0...(oldTilesX + 1))
                {
                    if (LDtkController.hasCollision(oldCx + i, newCy))
                    {
                        pos.y = (oldCy + spNeg) * LDtkController.TRUE_TILE_SIZE + 0.01;
                        velocity.y = 0;
                    }
                }
            }
        }
        size += new Vector(0.4, 0.4); // Bad fix for getting into tight corridors
        // --- Old logic:
        // var sizeRatio : Float = size.x / LDtkController.TRUE_TILE_SIZE;
        // var xx : Float = xRect.centre.x;
        // var yy : Float = yRect.centre.y;
        // var cx : Int = Math.floor(xx / LDtkController.TRUE_TILE_SIZE);
        // var xr : Float = (xx - cx * LDtkController.TRUE_TILE_SIZE) / LDtkController.TRUE_TILE_SIZE;
        // var cy : Int = Math.floor(yy / LDtkController.TRUE_TILE_SIZE);
        // var yr : Float = (yy - cy * LDtkController.TRUE_TILE_SIZE) / LDtkController.TRUE_TILE_SIZE;
        // var spPos : Float = 1 - sizeRatio / 2;
        // var spNeg : Float = sizeRatio / 2;
        // trace("c: (" + cx + ", " + cy + "), r: (" + xr + ", " + yr + "), t: (" + xx + ", " + yy + ")");
        // if (velocity.x > 0 && xr >= spPos && LDtkController.hasCollision(cx + 1, cy))
        // {
        //     pos.x = (cx + spPos) * LDtkController.TRUE_TILE_SIZE;
        //     velocity.x = 0;
        // }
        // else if (velocity.x < 0 && xr <= spNeg && LDtkController.hasCollision(cx - 1, cy))
        // {
        //     pos.x = (cx + spNeg) * LDtkController.TRUE_TILE_SIZE;
        //     velocity.x = 0;
        // }
        // if (velocity.y > 0 && yr >= spPos && LDtkController.hasCollision(cx, cy + 1))
        // {
        //     pos.y = (cy + spPos) * LDtkController.TRUE_TILE_SIZE;
        //     velocity.y = 0;
        //     grounded = true;
        // }
        // else if (velocity.y < 0 && yr <= spNeg && LDtkController.hasCollision(cx, cy - 1))
        // {
        //     pos.y = (cy + spNeg) * LDtkController.TRUE_TILE_SIZE;
        //     velocity.y = 0;
        // }
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