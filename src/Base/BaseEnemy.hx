class BaseEnemy extends BaseHealthEntity
{
    override function get_tags():EntityType
    {
        return EntityType.Enemy;
    }
}