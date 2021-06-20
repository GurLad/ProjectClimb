import MultiAnimationRenderer.MutiAnimationRenderer;

class PlayerRock extends BasePlayerProjectile
{
    public function new(pos : Vector, speed : Float, direction : Int)
    {
        super(pos, new Vector(16, 16) * 2, null, new Vector(1, 0) * speed);
        var anim = MutiAnimationRenderer.newSingleAnimation(hxd.Res.RollingRock, 16);
        anim.flipX = direction > 0;
        renderer = anim;
        renderer.init(this);
    }

    override function fixedUpdate(timeScale:Float)
    {
        super.fixedUpdate(timeScale);
        if (velocity.x == 0)
        {
            destroy();
        }
    }

    override function onTilemapCollide() {}

    override function get_damage():Int {
        return 2;
    }
}