class UILifebar
{
    private static var OFFSET(default, never) : Int = 48;

    private var lifeIcons : Array<UIImage> = new Array<UIImage>();
    private var lastHealth : Int;
    private var maxHealth : Int;
    private var entity : BaseHealthEntity;

    public function new(entity : BaseHealthEntity, basePos : Vector)
    {
        this.entity = entity;
        maxHealth = lastHealth = entity.health;
        for (i in 0...maxHealth)
        {
            lifeIcons.push(new UIImage(
                basePos + new Vector(OFFSET * i, 0),
                LDtkController.SIZE_MOD,
                hxd.Res.HeartFull));
        }
        entity.onPostHit = updateBar;
        trace("a");
    }

    private function updateBar()
    {
        if (entity.health <= 0)
        {
            for (i in 0...maxHealth)
            {
                lifeIcons[i].remove();
            }
            return;
        }
        for (i in entity.health...lastHealth)
        {
            lifeIcons[i].setImage(hxd.Res.HeartEmpty);
        }
        lastHealth = entity.health;
    }
}