import MultiAnimationRenderer.MutiAnimationRenderer;

class PlayerBuilder
{
    public static var playerSpells(default, never) : Array<Int> = [0, 0]; // Should replace with saved data
    private static var groundSpells(default, never) : Array<(e : BaseAnimatedPhysicsEntity) -> Void> = [groundFire, groundWater, groundAir];
    private static var airSpells(default, never) : Array<(e : BaseAnimatedPhysicsEntity) -> Void> = [airFire, airWater, airAir];

    public static function newBlunk(playerID : Int, pos : Vector) : ControlableEntity
    {
        var map = new AnimationMap();
        map.addToMap(hxd.Res.Idle, "Idle");
        map.addToMap(hxd.Res.Walk, "Walk");
        map.addToMap(hxd.Res.Hit, "Hit");
        map.addToMap(hxd.Res.CastGroundStart, "GroundAttackStart");
        map.addToMap(hxd.Res.CastGroundEnd, "GroundAttackEnd");
        map.addToMap(hxd.Res.CastAirStart, "AirAttackStart");
        map.addToMap(hxd.Res.CastAirEnd, "AirAttackEnd");
        map.addToMap(hxd.Res.BlinkStart, "JumpStart");
        map.addToMap(hxd.Res.BlinkEnd, "JumpEnd");
        var groundAttackSpell = groundSpells[playerSpells[playerID]];
        var airAttackSpell = airSpells[playerSpells[playerID]];
        var jumpSpell = (e : BaseAnimatedPhysicsEntity) ->
        {
            var trueE = cast(e, ControlableEntity);
            trueE.size -= new Vector(0.4, 0.4); // Bad fix for getting into tight corridors
            // Teleport
            var dist = 5;
            var dir : Vector = new Vector(Input.getAxisX(playerID), Input.getAxisY(playerID)).normalized;
            trueE.velocity = dir * LDtkController.TRUE_TILE_SIZE / 2;
            var xRect, yRect, rect : Rectangle;
            xRect = trueE.rect.clone();
            yRect = trueE.rect.clone();
            while (dist > 0 && trueE.velocity != Vector.ZERO)
            {
                rect = trueE.rect.clone();
                xRect.topLeft += trueE.velocity.xVector;
                yRect.topLeft += trueE.velocity.yVector;
                var oldP : GridPos = new GridPos(rect);
                var newP : GridPos = GridPos.fromTwoRects(xRect, yRect);
                var collided = trueE.checkAllTilemapCollisions(newP, oldP);
                trueE.pos += trueE.velocity;
                dist--;
            }
            trueE.velocity = dir * trueE.speed;
            trueE.size += new Vector(0.4, 0.4); // Bad fix for getting into tight corridors
        }

        return new ControlableEntity(
            playerID,
            pos,
            new Vector(64,64),
            new MutiAnimationRenderer(map, 32, "Idle"),
            5, 5, 5,
            new Spell("GroundAttackStart", "GroundAttackEnd", groundAttackSpell),
            new Spell("AirAttackStart", "AirAttackEnd", airAttackSpell),
            new Spell("JumpStart", "JumpEnd", jumpSpell));
    }

    private static function groundFire(e : BaseAnimatedPhysicsEntity)
    {
        var trueE = cast(e, ControlableEntity);
        new PlayerFireball(
            e.pos + e.size.xVector / 2 * trueE.direction,
            trueE.speed * trueE.direction * 2, trueE.direction);
    }

    private static function airFire(e : BaseAnimatedPhysicsEntity)
    {
        new PlayerBoom(e);
    }

    private static function groundWater(e : BaseAnimatedPhysicsEntity)
    {
        var trueE = cast(e, ControlableEntity);
        var pos : Vector = e.pos + e.size.xVector / 2 * trueE.direction;
        var speed : Float = trueE.speed * 1.2;
        var direction : Vector = new Vector(trueE.direction, 0);
        for (i in -1...2)
        {
            direction.y = i;
            new PlayerWaterball(pos, speed, direction.normalized);
        }
    }

    private static function airWater(e : BaseAnimatedPhysicsEntity)
    {
        var trueE = cast(e, ControlableEntity);
        var pos : Vector = e.pos;
        var speed : Float = trueE.speed * 1.2;
        var size : Float = trueE.size.size / 2;
        var direction : Vector = new Vector(0, 0);
        for (i in -1...2)
        {
            for (j in -1...2)
            {
                if (i == 0 && j == 0)
                {
                    continue;
                }
                direction.y = i;
                direction.x = j;
                new PlayerWaterball(pos + direction.normalized * size, speed, direction.normalized);
            }
        }
    }

    private static function groundAir(e : BaseAnimatedPhysicsEntity)
    {
        var trueE = cast(e, ControlableEntity);
        new PlayerAirBoom(e.pos + e.size.xVector / 2 * trueE.direction);
        trueE.velocity.x = trueE.speed * 2 * -trueE.direction;
        trueE.velocity.y = Math.min(-trueE.jumpForce / 5, trueE.velocity.y);
        trueE.stunDuration = 0.1;
    }

    private static function airAir(e : BaseAnimatedPhysicsEntity)
    {
        var trueE = cast(e, ControlableEntity);
        new PlayerAirBoom(e.pos + e.size.yVector / 2);
        trueE.velocity.y = -trueE.jumpForce;
    }
}