class BaseHealthEntity extends BaseAnimatedPhysicsEntity
{
    private static var INVINCIBLE_TIME(default, never) : Float = 0.5; // No idea how to call this

    public var health : Int;
    public var onPostHit : () -> Void;
    private var invincibilityDuration : Float = 0;

    override function preUpdate(timeScale:Float)
    {
        super.preUpdate(timeScale);
        if (invincibilityDuration > 0)
        {
            invincibilityDuration -= timeScale / Main.TARGET_FPS;
            if (invincibilityDuration == 0) // How?
            {
                animation.alpha = 1;
            }
        }
        else if (invincibilityDuration < 0)
        {
            invincibilityDuration = 0;
            animation.alpha = 1;
        }
    }

    override function onCollide(collider:Entity)
    {
        if (invincibilityDuration > 0)
        {
            return;
        }
        super.onCollide(collider);
        if ((collider is BaseProjectile) && collider.tags & tags & (EntityType.Player | EntityType.Enemy) == 0) // Has different tags, aka different player/enemy
        {
            takeDamage((cast(collider, BaseProjectile)).damage);
            onHit(collider);
        }
    }

    public function takeDamage(value : Int)
    {
        health -= value;
        if (health <= 0)
        {
            destroy();
        }
        else 
        {
            animation.alpha = 0.7;
            invincibilityDuration = INVINCIBLE_TIME;
        }
    }

    public function onHit(entity : Entity)
    {
        if (onPostHit != null)
        {
            onPostHit();
        }
    }
}