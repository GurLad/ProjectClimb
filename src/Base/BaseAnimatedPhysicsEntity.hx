import MultiAnimationRenderer.MutiAnimationRenderer;

class BaseAnimatedPhysicsEntity extends PhysicsEntity
{
    private var animation : MutiAnimationRenderer;

    public function new(pos : Vector, size : Vector, renderer : MutiAnimationRenderer, ?velocity : Vector = null)
    {
        super(pos, size, renderer);
        animation = renderer;
    }
}