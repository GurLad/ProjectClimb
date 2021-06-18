import hxd.Math;

class BossFloor extends Entity // Very bad code because it does so much stuff most of the game doesn't need
{
    private var cx : Int;
    private var cy : Int;
    private var bossPos : Vector;
    private var faceRight : Bool;
    private var spawned : Bool = false;

    public function new(cx : Int, cy : Int, bossPos : Vector, faceRight : Bool)
    {
        pos = new Vector(32 + cx * LDtkController.TRUE_TILE_SIZE, 128 + cy * LDtkController.TRUE_TILE_SIZE);
        size = new Vector(64, 256);
        super(pos, size, new ImageRenderer(pos, 2, size, hxd.Res.BossFloor));
        this.cx = cx;
        this.cy = cy;
        this.bossPos = bossPos;
        this.faceRight = faceRight;
    }

    override function update(timeScale:Float)
    {
        if (spawned)
        {
            return;
        }
        super.update(timeScale);
        for (p in ControlableEntity.players)
        {
            if (p.rect.bottomLeft.y < rect.topLeft.y)
            {
                spawnBoss();
                return;
            }
        }
    }
    
    private function spawnBoss()
    {
        for (p in ControlableEntity.players)
        {
            p.pos.y = Math.min(pos.y - size.y, p.pos.y);
            p.pos.x = Math.clamp(p.pos.x, pos.x - size.x / 2, pos.x + size.x / 2);
        }
        for (i in 0...4)
        {
            LDtkController.tileData[cx + i][cy] = 1;
        }
        EnemyBuilder.newBossSnail(bossPos, faceRight);
        Main.playMusic(hxd.Res.QuakeAndTremble1_1);
        spawned = true;
    }
}