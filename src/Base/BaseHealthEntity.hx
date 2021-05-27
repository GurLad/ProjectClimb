class BaseHealthEntity extends PhysicsEntity
{
    public var health : Int;

    override function onCollide(collider:Entity)
    {
        super.onCollide(collider);
        if ((collider is BaseProjectile) && collider.tags & tags & (EntityType.Player | EntityType.Enemy) == 0) // Has different tags, aka different player/enemy
        {
            health -= (cast(collider, BaseProjectile)).damage;
            if (health <= 0)
            {
                destroy();
            }
        }
    }
}