class UILifebar
{
    private static var OFFSET(default, never) : Int = 48;
    private static var MAX_PER_ROW(default, never) : Int = 5;

    private var lifeIcons : Array<UIImage> = new Array<UIImage>();
    private var lastHealth : Int;
    private var maxHealth : Int;
    private var entity : BaseHealthEntity;

    public function new(entity : BaseHealthEntity, basePos : Vector, heartFull : hxd.res.Image)
    {
        this.entity = entity;
        maxHealth = lastHealth = entity.health;
        for (i in 0...maxHealth)
        {
            lifeIcons.push(new UIImage(
                basePos + new Vector(OFFSET * Math.floor(i % MAX_PER_ROW), OFFSET * Math.floor(i / MAX_PER_ROW)),
                LDtkController.SIZE_MOD,
                heartFull));
        }
        entity.onPostHit = updateBar;
    }

    private function updateBar()
    {
        if (entity.health <= 0)
        {
            for (i in 0...maxHealth)
            {
                lifeIcons[i].setImage(hxd.Res.HeartEmpty);
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