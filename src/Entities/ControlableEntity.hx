import hxd.Math;
import MultiAnimationRenderer.MutiAnimationRenderer;
import hxd.Key;

class ControlableEntity extends BaseHealthEntity
{
    private static var MOVEMENT_LERP_VALUE(default, never) : Float = 0.2; // No idea how to call this
    public var speed : Float;
    public var jumpForce : Float;
    public var direction : Int = 1;
    private var playerID : Int;
    private var canSuperJump : Bool;
    private var attackGroundSpell : Spell;
    private var attackAirSpell : Spell; // TBA
    private var jumpSpell : Spell; // TBA
    private var currentSpell : Spell;

    public function new(playerID : Int, pos : Vector, size : Vector, renderer : MutiAnimationRenderer, attackGroundSpell : Spell, speed : Float, jumpForce : Float)
    {
        super(pos, size, renderer);
        this.playerID = playerID;
        this.speed = speed;
        this.jumpForce = jumpForce;
        this.attackGroundSpell = attackGroundSpell;
        this.attackGroundSpell.entity = this;
    }

    override function get_tags():EntityType
    {
        return EntityType.Player;
    }

    public override function preUpdate(timeScale:Float)
    {
        super.preUpdate(timeScale);
        if (currentSpell != null && currentSpell.casting)
        {
            velocity.x = 0;
            return;
        }
        if (Input.getLeft(playerID))
        {
            velocity.x = Math.lerp(velocity.x, -speed, MOVEMENT_LERP_VALUE * timeScale);
            animation.play("Walk");
            animation.flipX = false;
            direction = -1;
        }
        else if (Input.getRight(playerID))
        {
            velocity.x = Math.lerp(velocity.x, speed, MOVEMENT_LERP_VALUE * timeScale);
            animation.play("Walk");
            animation.flipX = true;
            direction = 1;
        }
        else
        {
            var previousVelocity = velocity.x;
            velocity.x = Math.lerp(velocity.x, 0, MOVEMENT_LERP_VALUE * timeScale);
            if (previousVelocity * velocity.x < 0) // Passed target
            {
                velocity.x = 0;
            }
            animation.play("Idle");
        }
        if (Input.getHop(playerID) && grounded) // Hop
        {
            velocity.y = -jumpForce;
        }
        if (Input.getJump(playerID) && canSuperJump) // Jump
        {
            velocity.y = -jumpForce * 1.7;
            canSuperJump = false;
        }
        if (Input.getCast(playerID)) // Attack
        {
            (currentSpell = attackGroundSpell).begin();
        }
    }

    override function fixedUpdate(timeScale:Float) {
        canSuperJump = canSuperJump || grounded;
    }

    override function onCollide(collider:Entity) {
        super.onCollide(collider);
    }
}