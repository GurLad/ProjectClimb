import MultiAnimationRenderer.MutiAnimationRenderer;

class PlayerFireball extends BasePlayerProjectile
{
    public function new(pos : Vector, speed : Float, direction : Int)
    {
        super(pos, new Vector(16, 16) * 2, null, new Vector(1, 0) * speed);
        var anim = MutiAnimationRenderer.newSingleAnimation(hxd.Res.Fireball, 16);
        anim.flipX = direction > 0;
        renderer = anim;
        renderer.init(this);
        useGravity = false;
    }

    override function get_damage():Int {
        return 2;
    }
}