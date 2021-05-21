class Entity
{
    public static var entities(default, null) : List<Entity> = new List<Entity>();

    public var pos : Vector;
    public var size : Vector;
    public var dead : Bool;
    private var renderer : IRenderer;

    public var rect(get,set) : Rectangle;
    function get_rect()
    {
        return Rectangle.fromCentreAndSize(pos, size);
    }
    function set_rect(value : Rectangle)
    {
        pos = value.centre;
        size = value.size;
        return value;
    }

    public function new(pos : Vector, size : Vector, renderer : IRenderer)
    {
        this.pos = pos;
        this.size = size;
        this.renderer = renderer;
        this.renderer.init();
        render();
        entities.add(this);
    }

    public function destroy()
    {
        dead = true;
    }

    public function update(timeScale : Float) {} // abstract

    public function lateUpdate(timeScale : Float) {} // abstract

    public final function cleanup()
    {
        if (dead)
        {
            renderer.remove();
            entities.remove(this);
        }
    }

    public function render()
    {
        renderer.x = rect.topLeft.x;
        renderer.y = rect.topLeft.y;
        renderer.scaleX = size.x;
        renderer.scaleY = size.y;
    }
}