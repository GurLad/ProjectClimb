import MultiAnimationRenderer.MutiAnimationRenderer;

class PlayerAirBoom extends BasePlayerProjectile
{
    public function new(pos : Vector)
    {
        super(pos, new Vector(32, 32) * 2);
        var anim = MutiAnimationRenderer.newSingleAnimation(hxd.Res.AirAttack, 32);
        anim.loop = false;
        anim.onAnimationEnd = () -> destroy();
        renderer = anim;
        renderer.init(this);
        lockPosition = true;
    }

    override function get_damage():Int {
        return 2;
    }
}