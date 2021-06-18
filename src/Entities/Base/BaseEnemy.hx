class BaseEnemy extends BaseHealthEntity
{
    public var damage(get, null) : Int;
    public var isBoss : Bool;

    function get_damage()
    {
        return 1;
    }

    override function get_tags():EntityType
    {
        return EntityType.Enemy;
    }

    override function onHit(entity:Entity) {
        super.onHit(entity);
        if (dead && isBoss)
        {
            LDtkController.loadNextLevel();
        }
    }
}