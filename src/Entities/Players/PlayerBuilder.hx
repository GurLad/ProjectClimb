import MultiAnimationRenderer.MutiAnimationRenderer;

class PlayerBuilder
{
    public static function newBlunk(playerID : Int, pos : Vector) : ControlableEntity
    {
        var map = new AnimationMap();
        map.addToMap(hxd.Res.Idle, "Idle");
        map.addToMap(hxd.Res.Walk, "Walk");
        map.addToMap(hxd.Res.CastGroundStart, "GroundAttackStart");
        map.addToMap(hxd.Res.CastGroundEnd, "GroundAttackEnd");
        var groundAttackSpell = (e : BaseAnimatedPhysicsEntity) ->
        {
            var trueE = cast(e, ControlableEntity);
            new TempPlayerFireball(e.pos + e.size.xVector * trueE.direction, new Vector(5,5), new ColorRenderer(0xFF0000), new Vector(trueE.speed * trueE.direction, 0) * 2);
        }

        return new ControlableEntity(
            playerID,
            pos,
            new Vector(64,64),
            new MutiAnimationRenderer(map, 32, "Idle"),
            new Spell("GroundAttackStart", "GroundAttackEnd", groundAttackSpell),
            5, 5);
    }
}