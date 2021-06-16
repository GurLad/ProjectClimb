import MultiAnimationRenderer.MutiAnimationRenderer;

class PlayerWaterball extends BasePlayerProjectile
{
    public function new(pos : Vector, speed : Float, direction : Vector)
    {
        super(pos, new Vector(8, 8) * 2, null, direction * speed);
        var image : hxd.res.Image = direction.x == 0 ? hxd.Res.WaterV : (direction.y == 0 ? hxd.Res.Water : hxd.Res.WaterDiagonal);
        var anim = MutiAnimationRenderer.newSingleAnimation(image, 8);
        anim.flipX = direction.x > 0;
        anim.flipY = direction.y > 0;
        renderer = anim;
        renderer.init(this);
        useGravity = false;
    }
}