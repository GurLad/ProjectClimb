class BaseHealthEntity extends BaseAnimatedPhysicsEntity
{
    public var health : Int;
    public var onPostHit : () -> Void;

    override function onCollide(collider:Entity)
    {
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
    }

    public function onHit(entity : Entity)
    {
        if (onPostHit != null)
        {
            onPostHit();
        }
    }
}