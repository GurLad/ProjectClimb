import MultiAnimationRenderer.MutiAnimationRenderer;

class PlayerRockForm extends BasePlayerProjectile
{
    private var toFollow : ControlableEntity;

    public function new(toFollow : ControlableEntity)
    {
        super(toFollow.pos, new Vector(32, 32) * 2);
        this.toFollow = toFollow;
        lockPosition = true;
    }

    override function fixedUpdate(timeScale:Float)
    {
        super.fixedUpdate(timeScale);
        pos = toFollow.pos;
        if (toFollow.stunDuration <= 0)
        {
            destroy();
        }
    }

    override function onCollide(collider:Entity)
    {
        super.onCollide(collider);
        if ((collider is BaseEnemy))
        {
            toFollow.velocity.y = -toFollow.jumpForce;
            toFollow.stunDuration = 0;
            toFollow.invincibilityDuration = 0.1;
            toFollow.canSuperJump = true;
            destroy();
        }
    }
}