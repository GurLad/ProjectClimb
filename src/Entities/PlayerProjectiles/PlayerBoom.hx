import MultiAnimationRenderer.MutiAnimationRenderer;

class PlayerBoom extends BasePlayerProjectile
{
    private var toFollow : Entity;

    public function new(toFollow : Entity)
    {
        super(toFollow.pos, new Vector(64, 64) * 2);
        this.toFollow = toFollow;
        lockPosition = true;
    }

    override function fixedUpdate(timeScale:Float) {
        if (renderer == null)
        {
            var anim = MutiAnimationRenderer.newSingleAnimation(hxd.Res.Boom, 64);
            anim.loop = false;
            anim.onAnimationEnd = () -> destroy();
            renderer = anim;
            renderer.init(this);
        }
        super.fixedUpdate(timeScale);
        pos = toFollow.pos;
    }

    override function get_damage():Int {
        return 2;
    }
}