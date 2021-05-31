class ObjectRenderer implements IRenderer extends h2d.Object
{
    public function new()
    {
        super(Main.entityLayer);
    }

	public function init(entity:Entity) {}

	public function dispose()
    {
        remove();
    }

	public function render(pos:Vector, size:Vector)
    {
        x = pos.x;
        y = pos.y;
        scaleX = size.x;
        scaleY = size.y;
    }
}