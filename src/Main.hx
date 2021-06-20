import MultiAnimationRenderer.MutiAnimationRenderer;
import hxd.res.Sound;
import h2d.Camera;
import hxd.Timer;
import h2d.Text;
import h2d.Scene;

class Main extends hxd.App {
    public static var TARGET_FPS(default, null) : Int = 60;
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
    private static var currentMusic : hxd.res.Sound;
    private var delay : Float = 0;
    private var fpsDisplay : Text;

    override function init()
    {
        scene = s2d;
        hxd.Res.initEmbed();
        hxd.Window.getInstance().title = "Project Climb";
        Timer.wantedFPS = TARGET_FPS;

        // Set UI vs. Entities layers

        scene.addChildAt(uiLayer, 2);
        scene.addChildAt(entityLayer, 1);
        scene.addChildAt(tilemapLayer, 0);
        
        // Load menu

        LDtkController.loadLevel(0);
    }

    override function update(dt:Float)
    {
        var timeScale = dt * TARGET_FPS;
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

    static function main()
    {
        new Main();
    }

    public static function clearScene()
    {
        for (e in Entity.entities)
        {
            e.destroy();
            e.cleanup();
        }
        for (e in Entity.TBA)
        {
            e.destroy();
            e.cleanup();
        }
        for (ui in IUI.all)
        {
            ui.remove();
        }
        tilemapLayer.removeChildren();
    }

    public static function playMusic(music : hxd.res.Sound)
    {
        if (currentMusic == music)
        {
            return;
        }
        if (currentMusic != null)
        {
            currentMusic.stop();
        }
        //(currentMusic = music).play(true);
    }
}