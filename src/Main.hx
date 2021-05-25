import hxd.Timer;
import h2d.Text;
import h2d.Scene;

class Main extends hxd.App {
    public static var scene : Scene;
    private var delay : Float = 5;
    private var fpsDisplay : Text;

    override function init() {
        scene = s2d;

        // FPS display

        var font : h2d.Font = hxd.res.DefaultFont.get();
        fpsDisplay = new h2d.Text(font);
        fpsDisplay.text = "FPS: ";
        fpsDisplay.textAlign = Left;
        s2d.addChild(fpsDisplay);
        
        // Demo - move to a different file afterwards

        // Known physics bugs:
        // -If an entity moves too fast, it may end up on the other side of a block.

        var block1 = new ControlableEntity(new Vector(120,30), new Vector(50,50), new ColorRenderer(0xFFFFFF), 5, 5);
        var block2 = new Entity(new Vector(200,230), new Vector(400,20), new ColorRenderer(0xFF0000));
        var block2 = new Entity(new Vector(500,200), new Vector(40,40), new ColorRenderer(0x0000FF));
        var block2 = new Entity(new Vector(460,300), new Vector(20,20), new ColorRenderer(0x00FF00));
        var block3 = new Entity(new Vector(600,230), new Vector(40,200), new ColorRenderer(0xFF00FF));
        var block4 = new Entity(new Vector(500,530), new Vector(1000,20), new ColorRenderer(0xFFFF00));
        var block5 = new BaseEnemy(new Vector(720,30), new Vector(30,30), new ColorRenderer(0x00FFFF), new Vector(2,0));
        var block5 = new BaseEnemy(new Vector(500,0), new Vector(60,60), new ColorRenderer(0xAAFF00), new Vector(-1,0));
        var block5 = new BaseEnemy(new Vector(860,-50), new Vector(100,20), new ColorRenderer(0x00AAFF), new Vector(0,0));
        var block5 = new BaseEnemy(new Vector(100,300), new Vector(30,50), new ColorRenderer(0xFF00AA), new Vector(20,0));
        var block5 = new Entity(new Vector(900,490), new Vector(30,50), new ColorRenderer(0xFFAAAA));
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
            entity.render();
        }
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