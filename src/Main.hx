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
    public static var camera(get, never) : h2d.Camera;
    public static function get_camera() : h2d.Camera
    {
        return scene.camera;
    }
    public static var SCREEN_SIZE(default, null) = new Vector(1280, 720);
    private static var scene : Scene;
    private var delay : Float = 3;
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