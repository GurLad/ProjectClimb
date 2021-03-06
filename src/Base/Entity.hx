import EntityType;

class Entity
{
    public static var entities(default, null) : List<Entity> = new List<Entity>(); // Should've renamed to all, but too late now
    public static var TBA(default, null) : List<Entity> = new List<Entity>();

    public var pos : Vector;
    public var size : Vector;
    public var dead : Bool;
    public var name : String;
    public var tags(get, null) : EntityType;
    public function get_tags() : EntityType
    {
        return EntityType.None;
    }
    private var renderer : IRenderer;

    public var rect(get,set) : Rectangle;
    function get_rect()
    {
        return Rectangle.fromCentreAndSize(pos, size);
    }
    function set_rect(value : Rectangle)
    {
        pos = value.centre.clone();
        size = value.size.clone();
        return value;
    }

    public function new(pos : Vector, size : Vector, ?renderer : IRenderer = null)
    {
        this.pos = pos.clone();
        this.size = size.clone();
        this.renderer = renderer;
        if (renderer != null)
        {
            this.renderer.init(this);
        }
        render(1);
        TBA.add(this);
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
            if (renderer != null)
            {
                renderer.dispose();
            }
            entities.remove(this);
        }
    }

    public function render(timeScale : Float)
    {
        if (renderer != null)
        {
            renderer.render(rect.topLeft, size);
        }
    }
}