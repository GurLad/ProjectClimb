import hxd.Math;
import h2d.Camera;

class CameraFollower extends Entity
{
    private static var LERP_VALUE(default, never) : Float = 0.2; // No idea how to call this
    private var camera : Camera;
    private var toFollow : Entity;
    public function new(camera : Camera, toFollow : Entity)
    {
        super(new Vector(0, LDtkController.levelSize.y * LDtkController.TRUE_TILE_SIZE - Main.SCREEN_SIZE.y), Vector.ZERO, null);
        this.camera = camera;
        this.toFollow = toFollow;
    }

    public override function render(timeScale : Float)
    {
        if (camera != null)
        {
            camera.setPosition(0, Math.lerp(camera.y, toFollow.pos.y - Main.SCREEN_SIZE.y / 2, LERP_VALUE * timeScale));
        }
    }
}