import hxd.Math;
import h2d.Camera;

class CameraFollower extends Entity
{
    private static var LERP_VALUE(default, never) : Float = 0.2; // No idea how to call this
    private var camera : Camera;
    private var toFollow : List<Entity>;
    public function new(camera : Camera, toFollow : List<Entity>)
    {
        super(new Vector(0, LDtkController.levelSize.y * LDtkController.TRUE_TILE_SIZE - Main.SCREEN_SIZE.y), Vector.ZERO, null);
        this.camera = camera;
        this.toFollow = toFollow;
        camera.setPosition(0, targetPos());
    }

    public override function render(timeScale : Float)
    {
        if (camera != null)
        {
            for (i in toFollow.filter(a -> a.dead))
            {
                toFollow.remove(i);
            }
            camera.setPosition(0, Math.lerp(camera.y, targetPos(), LERP_VALUE * timeScale));
        }
    }

    private function targetPos() : Float
    {
        var sum : Float = 0;
        for (i in toFollow)
        {
            sum += i.pos.y;
        }
        var target = Math.clamp(sum / toFollow.length - Main.SCREEN_SIZE.y / 2, 0, LDtkController.levelSize.y * LDtkController.TRUE_TILE_SIZE - Main.SCREEN_SIZE.y);
        return target;
    }
}