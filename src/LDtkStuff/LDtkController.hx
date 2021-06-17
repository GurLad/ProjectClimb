class LDtkController
{
    public static var SIZE_MOD(default, never) : Int = 2;
    public static var TILE_SIZE(default, never) : Int = 32;
    public static var TRUE_TILE_SIZE(default, never) : Int = SIZE_MOD * TILE_SIZE;
    public static var tileData : Array2D<Int>;
    public static var levelSize : Vector;
    private static var project(default, never) : LDtk = new LDtk();

    public static function loadLevel(id : Int)
    {
        // Clear previous level
        Main.clearScene();

        // Load new one
        switch (id)
        {
            case 0: // Menu
                new UIImage(Vector.ZERO, 2, hxd.Res.Menu);
                new UIButton(new Vector(1280 / 2 - 112, 624), 2, hxd.Res.StartButton, () -> LDtkController.loadLevel(1));
                new UIButton(new Vector(1280 / 2 - 112, 672), 2, hxd.Res.QuitButton, () -> hxd.System.exit());
                Main.playMusic(hxd.Res.TheClimb);
            case 1:
                loadLevelData(project.all_levels.Level_1);
                Main.playMusic(hxd.Res.TheForgotten);
            default:
                return;
        }
    }

    public static function hasCollision(cx : Int, cy : Int) : Bool
    {
        if (cx < 0 || cy < 0 || cx >= levelSize.x || cy >= levelSize.y)
        {
            return true;
        }
        return tileData[cx][cy] == 1;
    }

    private static function loadLevelData(level : LDtk.LDtk_Level)
    {
        // Get level background image
        if( level.hasBgImage() ) {
            var background = level.getBgBitmap();
            Main.tilemapLayer.addChild( background );
        }

        // Render an auto-layer 
        var layerRender = level.l_BackgroundLayer.render();
        layerRender.scale(SIZE_MOD);
        Main.tilemapLayer.addChild( layerRender );
        layerRender = level.l_BaseLayer.render();
        layerRender.scale(SIZE_MOD);
        Main.tilemapLayer.addChild( layerRender );
        levelSize = new Vector(level.l_BaseLayer.cWid, level.l_BaseLayer.cHei);

        // UI
        new UIImage(new Vector(LDtkController.levelSize.x * LDtkController.TRUE_TILE_SIZE, 0), 2, hxd.Res.Panel);
        new UIButton(new Vector(LDtkController.levelSize.x * LDtkController.TRUE_TILE_SIZE + 16, 624), 2, hxd.Res.MenuButton, () -> LDtkController.loadLevel(0));
        new UIButton(new Vector(LDtkController.levelSize.x * LDtkController.TRUE_TILE_SIZE + 16, 672), 2, hxd.Res.QuitButton, () -> hxd.System.exit());

        // Load entities
        var entityLayer = level.l_Entities;
        for (snail in entityLayer.all_SnailEnemy)
        {
            EnemyBuilder.newSnail(getEntityPos(snail), snail.f_FaceRight);
        }
        for (snail in entityLayer.all_FlyingSnail)
        {
            EnemyBuilder.newFlyingSnail(getEntityPos(snail), snail.f_FaceRight);
        }
        for (player in entityLayer.all_Player)
        {
            var newPlayer = PlayerBuilder.newBlunk(player.f_PlayerID, getEntityPos(player));
            var lifebar = new UILifebar(newPlayer, levelSize.xVector * TRUE_TILE_SIZE + new Vector(16, 64 + 96 * player.f_PlayerID));
            // TEMP
            if (player.f_PlayerID == 0)
            {
                var cam = new CameraFollower(Main.camera, newPlayer);
            }
        }
        
        // Save tile data
        tileData = Array2D.fromFunction(level.l_BaseLayer.cWid, level.l_BaseLayer.cHei, (x : Int, y : Int) -> cast(level.l_BaseLayer.getInt(x,y), Int));
    }

    private static function getEntityPos(entity : ldtk.Entity) : Vector
    {
        return new Vector(entity.pixelX, entity.pixelY) * SIZE_MOD;
    }
}