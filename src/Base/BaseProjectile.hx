class BaseProjectile extends PhysicsEntity
{
    public var damage(get, null) : Int;
    function get_damage()
    {
        return 0;
    }

    override function get_tags():EntityType
    {
        return EntityType.Projectile;
    }

    override function onTilemapCollide()
    {
        destroy();
    }
}