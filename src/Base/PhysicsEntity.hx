class PhysicsEntity extends Entity
{
    private static var GRAVITY_SCALE(default, null) : Float = 9.81 / Main.TARGET_FPS;

    public var velocity : Vector;
    public var useGravity : Bool = true;
    public var lockPosition : Bool = false;
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
        if (lockPosition) // Skip physics
        {
            fixedUpdate(timeScale);
            return;
        }
        
        // Physics - TBA: Change to only happen at ~30 FPS (to increase performance)
        if (useGravity)
        {
            velocity.y += GRAVITY_SCALE * timeScale;
        }
        grounded = false;

        // Collisions
        size -= new Vector(0.4, 0.4); // Bad fix for getting into tight corridors
        var dirX, dirY : Float;
        var xRect, yRect : Rectangle;
        xRect = rect.clone();
        xRect.topLeft += velocity.xVector * timeScale;
        yRect = rect.clone();
        yRect.topLeft += velocity.yVector * timeScale;

        // Tilemap collisions
        // --- New logic:
        // TODO: make Vector generic type, default Float, for Int vectors
        var oldP : GridPos = new GridPos(rect);
        var newP : GridPos = GridPos.fromTwoRects(xRect, yRect);
        var tilemapCollided : Bool = checkAllTilemapCollisions(newP, oldP);
        size += new Vector(0.4, 0.4); // Bad fix for getting into tight corridors
        if (tilemapCollided)
        {
            onTilemapCollide();
        }

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

    public function checkAllTilemapCollisions(newP : GridPos, oldP : GridPos) : Bool
    {
        var sizeRatio : Float = size.x / LDtkController.TRUE_TILE_SIZE;
        var spPos : Float = 1 - sizeRatio / 2;
        var spNeg : Float = sizeRatio / 2;
        var tilemapCollided : Bool = false;
        if (velocity.x >= velocity.y)
        {
            if (!(tilemapCollided = xCollided(newP, oldP, spPos, spNeg)))
            {
                oldP.cx = newP.cx;
                oldP.tx = newP.tx;
            }
            tilemapCollided = yCollided(newP, oldP, spPos, spNeg) || tilemapCollided;
        }
        else
        {
            if (!(tilemapCollided = yCollided(newP, oldP, spPos, spNeg)))
            {
                oldP.cy = newP.cy;
                oldP.ty = newP.ty;
            }
            tilemapCollided = xCollided(newP, oldP, spPos, spNeg) || tilemapCollided;
        }
        return tilemapCollided;
    }

    private function xCollided(newP : GridPos, oldP : GridPos, spPos : Float, spNeg : Float) : Bool
    {
        if (velocity.x > 0)
        {
            if (newP.cx + newP.tx > oldP.cx + oldP.tx)
            {
                for (i in 0...(oldP.ty + 1))
                {
                    if (LDtkController.hasCollision(newP.cx + newP.tx, oldP.cy + i))
                    {
                        pos.x = (oldP.cx + oldP.tx + spPos) * LDtkController.TRUE_TILE_SIZE - 0.01;
                        velocity.x = 0;
                        return true;
                    }
                }
            }
        }
        else if (velocity.x < 0)
        {
            if (newP.cx < oldP.cx)
            {
                for (i in 0...(oldP.ty + 1))
                {
                    if (LDtkController.hasCollision(newP.cx, oldP.cy + i))
                    {
                        pos.x = (oldP.cx + spNeg) * LDtkController.TRUE_TILE_SIZE + 0.01;
                        velocity.x = 0;
                        return true;
                    }
                }
            }
        }
        return false;
    }

    private function yCollided(newP : GridPos, oldP : GridPos, spPos : Float, spNeg : Float) : Bool
    {
        if (velocity.y > 0)
        {
            if (newP.cy + newP.ty > oldP.cy + oldP.ty)
            {
                for (i in 0...(oldP.tx + 1))
                {
                    if (LDtkController.hasCollision(oldP.cx + i, newP.cy + newP.ty))
                    {
                        pos.y = (oldP.cy + oldP.ty + spPos) * LDtkController.TRUE_TILE_SIZE - 0.01;
                        velocity.y = 0;
                        grounded = true;
                        return true;
                    }
                }
            }
        }
        else if (velocity.y < 0)
        {
            if (newP.cy < oldP.cy)
            {
                for (i in 0...(oldP.tx + 1))
                {
                    if (LDtkController.hasCollision(oldP.cx + i, newP.cy))
                    {
                        pos.y = (oldP.cy + spNeg) * LDtkController.TRUE_TILE_SIZE + 0.01;
                        velocity.y = 0;
                        return true;
                    }
                }
            }
        }
        return false;
    }

    public function preUpdate(timeScale:Float) {} // Abstract

    public function fixedUpdate(timeScale:Float) {} // Abstract

    public function onCollide(collider:Entity) {} // Abstract

    public function onTilemapCollide() {} // Abstract
}