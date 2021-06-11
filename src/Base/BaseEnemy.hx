class BaseEnemy extends BaseHealthEntity
{
    public var damage(get, null) : Int;
    function get_damage()
    {
        return 1;
    }

    override function get_tags():EntityType
    {
        return EntityType.Enemy;
    }
}