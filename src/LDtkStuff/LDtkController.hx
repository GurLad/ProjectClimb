class LDtkController
{
    public static var tileData : Array2D<Int>;

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
        layerRender.scale(2);
        Main.tilemapLayer.addChild( layerRender );
        layerRender.y -= level.l_BackgroundLayer.cHei * level.l_BackgroundLayer.gridSize * 2;
        layerRender = level.l_BaseLayer.render();
        layerRender.scale(2);
        layerRender.y -= level.l_BaseLayer.cHei * level.l_BaseLayer.gridSize * 2;
        Main.tilemapLayer.addChild( layerRender );


        tileData = Array2D.fromFunction(level.l_BaseLayer.cWid, level.l_BaseLayer.cHei, (x : Int, y : Int) -> cast(level.l_BaseLayer.getInt(x,y), Int));
    }
}