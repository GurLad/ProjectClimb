import MultiAnimationRenderer.MutiAnimationRenderer;
import hxd.res.Sound;
import h2d.Camera;
import hxd.Timer;
import h2d.Text;
import h2d.Scene;

class Main extends hxd.App {
    public static var tilemapLayer : h2d.Object = new h2d.Object();
    public static var entityLayer : h2d.Object = new h2d.Object();
    public static var uiLayer : h2d.Object = new h2d.Object();
    public static var SCREEN_SIZE(default, null) = new Vector(1280, 720);
    private static var scene : Scene;
    private var delay : Float = 5;
    private var fpsDisplay : Text;

    override function init() {
        scene = s2d;
        hxd.Res.initEmbed();

        // Set UI vs. Entities layers

        scene.addChildAt(uiLayer, 2);
        scene.addChildAt(entityLayer, 1);
        scene.addChildAt(tilemapLayer, 0);

        // FPS display

        var font : h2d.Font = hxd.res.DefaultFont.get();
        fpsDisplay = new h2d.Text(font);
        fpsDisplay.text = "FPS: ";
        fpsDisplay.textAlign = Left;
        uiLayer.addChild(fpsDisplay);
        
        // Demo - move to a different file afterwards

        // Known physics bugs:
        // -If an entity moves too fast, it may end up on the other side of a block.
        // -If an entity collides a tilemap block at the edge, the collision isn't detected.

        LDtkController.loadLevel(0);
        scene.camera.setPosition(0, LDtkController.levelSize.y * LDtkController.TRUE_TILE_SIZE - SCREEN_SIZE.y);

        var musicResource:hxd.res.Sound = null;
        //If we support mp3 we have our sound
        if(hxd.res.Sound.supportedFormat(Wav)){
            musicResource = cast(hxd.Res.TheForgotten, hxd.res.Sound);
        }  

        if(musicResource != null){
            //Play the music and loop it
            musicResource.play(true);
        }

        var tileSrc = hxd.Res.Idle.toTile();
        var tiles = tileSrc.gridFlatten(32);
        var map = new Map<String, Array<h2d.Tile>>();
        map.set("Idle", tiles);

        var block1 = new ControlableEntity(
            new Vector(800, LDtkController.levelSize.y * LDtkController.TRUE_TILE_SIZE - 256),
            new Vector(64,64),
            new MutiAnimationRenderer(map, 32, "Idle"),
            5, 5);
        var cam = new CameraFollower(scene.camera, block1);
        var block2 = new Entity(new Vector(200,230 - SCREEN_SIZE.y), new Vector(400,20), null);
        var enemy = EnemyBuilder.newSnail(new Vector(100, LDtkController.levelSize.y * LDtkController.TRUE_TILE_SIZE - 356));
        var enemy2 = EnemyBuilder.newSnail(new Vector(250, LDtkController.levelSize.y * LDtkController.TRUE_TILE_SIZE - 1156));
        var enemy3 = EnemyBuilder.newSnail(new Vector(170, LDtkController.levelSize.y * LDtkController.TRUE_TILE_SIZE - 756));
        // var block2 = new Entity(new Vector(500,200), new Vector(40,40), new ColorRenderer(0x0000FF));
        // var block2 = new Entity(new Vector(460,300), new Vector(20,20), new ColorRenderer(0x00FF00));
        // var block3 = new Entity(new Vector(600,230), new Vector(40,200), new ColorRenderer(0xFF00FF));
        // var block4 = new Entity(new Vector(500,530), new Vector(1000,20), new ColorRenderer(0xFFFF00));
        // var block5 = new BaseEnemy(new Vector(720,30), new Vector(30,30), new ColorRenderer(0x00FFFF), new Vector(2,0));
        // var block5 = new BaseEnemy(new Vector(500,0), new Vector(60,60), new ColorRenderer(0xAAFF00), new Vector(-1,0));
        // var block5 = new BaseEnemy(new Vector(860,-50), new Vector(100,20), new ColorRenderer(0x00AAFF), new Vector(0,0));
        // var block5 = new BaseEnemy(new Vector(100,300), new Vector(30,50), new ColorRenderer(0xFF00AA), new Vector(20,0));
        // var block5 = new Entity(new Vector(900,490), new Vector(30,50), new ColorRenderer(0xFFAAAA));
    }
    override function update(dt:Float) {
        var timeScale = dt * 60;
        fpsDisplay.text = "FPS: " + Math.round(Timer.fps()) + " / " + Timer.wantedFPS;
        delay -= dt;
        if (delay > 0)
        {
            return;
        }
        for (entity in Entity.entities)
        {
            entity.update(timeScale);
        }
        for (entity in Entity.TBA)
        {
            Entity.entities.add(entity);
        }
        Entity.TBA.clear();
        for (entity in Entity.entities)
        {
            entity.cleanup();
            entity.render(timeScale);
        }
        uiLayer.setPosition(scene.camera.x, scene.camera.y);
        for (entity in Entity.entities)
        {
            entity.lateUpdate(timeScale);
        }
        for (entity in Entity.TBA)
        {
            Entity.entities.add(entity);
        }
        Entity.TBA.clear();
        for (entity in Entity.entities)
        {
            entity.cleanup();
        }
    }
    static function main() {
        new Main();
    }
}