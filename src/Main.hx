import h2d.Scene;

class Main extends hxd.App {
    public static var scene : Scene;

    override function init() {
        scene = s2d;
        
        // Demo - move to a different file afterwards

        var block1 = new Entity(new Vector(150,230), new Vector(50,50), new ColorRenderer(0xFFFFFF));
        var block2 = new Entity(new Vector(200,430), new Vector(400,20), new ColorRenderer(0xFF0000));
    }
    override function update(dt:Float) {
        var timeScale = dt * 60;
        for (entity in Entity.entities)
        {
            entity.update(timeScale);
        }
        for (entity in Entity.entities)
        {
            entity.cleanup();
            entity.render();
        }
        for (entity in Entity.entities)
        {
            entity.lateUpdate(timeScale);
        }
        for (entity in Entity.entities)
        {
            entity.cleanup();
        }
    }
    static function main() {
        new Main();
    }
}