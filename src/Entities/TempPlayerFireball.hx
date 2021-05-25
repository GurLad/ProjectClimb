class TempPlayerFireball extends BaseProjectile
{
    override function get_tags():EntityType
    {
        return EntityType.Player | EntityType.Projectile;
    }

    override function get_damage():Int
    {
        return 1;
    }
}