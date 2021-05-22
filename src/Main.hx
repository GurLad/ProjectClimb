import h2d.Scene;

class Main extends hxd.App {
    public static var scene : Scene;

    override function init() {
        scene = s2d;
        
        // Demo - move to a different file afterwards

        var block1 = new PhysicsEntity(new Vector(120,30), new Vector(50,50), new ColorRenderer(0xFFFFFF), new Vector(5,0));
        var block2 = new Entity(new Vector(200,230), new Vector(400,20), new ColorRenderer(0xFF0000));
        var block3 = new Entity(new Vector(600,230), new Vector(40,200), new ColorRenderer(0xFF00FF));
        var block4 = new Entity(new Vector(500,530), new Vector(1000,20), new ColorRenderer(0xFFFF00));
        var block5 = new PhysicsEntity(new Vector(920,30), new Vector(30,30), new ColorRenderer(0x00FFFF), new Vector(-2,0));
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