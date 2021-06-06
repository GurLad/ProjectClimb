class LDtkController
{
    public static var SIZE_MOD(default, never) : Int = 2;
    public static var TILE_SIZE(default, never) : Int = 32;
    public static var TRUE_TILE_SIZE(default, never) : Int = SIZE_MOD * TILE_SIZE;
    public static var tileData : Array2D<Int>;
    public static var levelSize : Vector;

    public static function loadLevel(id : Int)
    {
        var project = new LDtk();
        // Get level data
        var level = project.all_levels.Level_1;

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

        // Load entities
        var entityLayer = level.l_Entities;
        for (snail in entityLayer.all_SnailEnemy)
        {
            EnemyBuilder.newSnail(getEntityPos(snail), snail.f_FaceRight);
        }
        for (player in entityLayer.all_Player)
        {
            var newPlayer = PlayerBuilder.newBlunk(player.f_PlayerID, getEntityPos(player));
            // TEMP
            if (player.f_PlayerID == 0)
            {
                var cam = new CameraFollower(Main.camera, newPlayer);
            }
        }
        

        tileData = Array2D.fromFunction(level.l_BaseLayer.cWid, level.l_BaseLayer.cHei, (x : Int, y : Int) -> cast(level.l_BaseLayer.getInt(x,y), Int));
    }

    public static function hasCollision(cx : Int, cy : Int) : Bool
    {
        if (cx < 0 || cy < 0 || cx >= levelSize.x || cy >= levelSize.y)
        {
            return false;
        }
        return tileData[cx][cy] == 1;
    }

    private static function getEntityPos(entity : ldtk.Entity) : Vector
    {
        return new Vector(entity.pixelX, entity.pixelY) * SIZE_MOD;
    }
}