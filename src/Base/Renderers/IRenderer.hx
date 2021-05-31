interface IRenderer
{
    public function init(entity : Entity) : Void;
    public function dispose() : Void;
    public function render(pos : Vector, size : Vector) : Void;
}