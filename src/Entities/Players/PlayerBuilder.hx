import MultiAnimationRenderer.MutiAnimationRenderer;

class PlayerBuilder
{
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
        var groundAttackSpell = (e : BaseAnimatedPhysicsEntity) ->
        {
            var trueE = cast(e, ControlableEntity);
            new PlayerFireball(
                e.pos + e.size.xVector * trueE.direction,
                trueE.speed * trueE.direction * 2, trueE.direction);
        }
        var airAttackSpell = (e : BaseAnimatedPhysicsEntity) ->
        {
            new PlayerBoom(e);
        }
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
            trace("Begin, velocity: ("+ trueE.velocity.x + ", " + trueE.velocity.y + ")");
            while (dist > 0 && trueE.velocity != Vector.ZERO)
            {
                rect = trueE.rect.clone();
                xRect.topLeft += trueE.velocity.xVector;
                yRect.topLeft += trueE.velocity.yVector;
                var oldP : GridPos = new GridPos(rect);
                var newP : GridPos = GridPos.fromTwoRects(xRect, yRect);
                var collided = trueE.checkAllTilemapCollisions(newP, oldP);
                trace((collided ? "Collided, dir: (" : "Empty, dir: (") + trueE.velocity.x + ", " + trueE.velocity.y + "), dist: " + dist);
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
}