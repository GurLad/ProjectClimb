import MultiAnimationRenderer.MutiAnimationRenderer;

class Spell
{
    public var casting : Bool;
    public var preCasting : Bool;
    public var entity : BaseAnimatedPhysicsEntity;
    private var startAnimation : String;
    private var endAnimation : String;
    private var onAnimationEnd : (entity : BaseAnimatedPhysicsEntity) -> Void;

    public function new(startAnimation : String, endAnimation : String, onAnimationEnd : (entity : BaseAnimatedPhysicsEntity) -> Void)
    {
        this.startAnimation = startAnimation;
        this.endAnimation = endAnimation;
        this.onAnimationEnd = onAnimationEnd;
    }

    public function begin()
    {
        preCasting = casting = true;
        entity.animation.loop = false;
        entity.animation.play(startAnimation);
        entity.animation.onAnimationEnd = () ->
        {
            preCasting = false;
            entity.animation.play(endAnimation);
            entity.animation.onAnimationEnd = () ->
            {
                casting = false;
                entity.animation.loop = true;
            }
            onAnimationEnd(entity);
        }
    }

    public function cancel()
    {
        preCasting = casting = false;
        entity.animation.loop = true;
        entity.animation.onAnimationEnd = () -> {};
    }
}