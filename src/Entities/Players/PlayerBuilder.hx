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
            e.velocity.y = -trueE.jumpForce * 1.7;
        }

        return new ControlableEntity(
            playerID,
            pos,
            new Vector(64,64),
            new MutiAnimationRenderer(map, 32, "Idle"),
            5, 5, 5,
            new Spell("GroundAttackStart", "GroundAttackEnd", groundAttackSpell),
            new Spell("AirAttackStart", "AirAttackEnd", airAttackSpell),
            new Spell("AirAttackStart", "AirAttackEnd", jumpSpell));
    }
}