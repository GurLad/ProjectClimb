import hxd.Math;
import MultiAnimationRenderer.MutiAnimationRenderer;
import hxd.Key;

class ControlableEntity extends BaseHealthEntity
{
    // Stats
    private static var MOVEMENT_LERP_VALUE(default, never) : Float = 0.2; // No idea how to call this
    private static var STUN_TIME(default, never) : Float = 0.5; // No idea how to call this
    public var speed : Float;
    public var jumpForce : Float;
    public var knockbackForce : Float = 5; // Var just in case someone will turn this into a Smash clone - technically const

    // Playtime data
    public var direction : Int = -1;
    private var playerID : Int;
    private var canSuperJump : Bool;
    private var stunDuration : Float = 0;
    private static var players(default, never) : List<ControlableEntity> = new List<ControlableEntity>();

    // Spell data
    private var attackGroundSpell : Spell;
    private var attackAirSpell : Spell;
    private var jumpSpell : Spell;
    private var currentSpell : Spell;

    public function new(playerID : Int, pos : Vector, size : Vector, renderer : MutiAnimationRenderer, speed : Float, jumpForce : Float, health : Int,
        attackGroundSpell : Spell, attackAirSpell : Spell, jumpSpell : Spell)
    {
        super(pos, size, renderer);
        this.playerID = playerID;
        this.speed = speed;
        this.jumpForce = jumpForce;
        this.health = health;
        this.attackGroundSpell = attackGroundSpell;
        this.attackGroundSpell.entity = this;
        this.attackAirSpell = attackAirSpell;
        this.attackAirSpell.entity = this;
        this.jumpSpell = jumpSpell;
        this.jumpSpell.entity = this;
        players.add(this);
    }

    override function get_tags():EntityType
    {
        return EntityType.Player;
    }

    public override function preUpdate(timeScale:Float)
    {
        super.preUpdate(timeScale);
        if (stunDuration > 0)
        {
            stunDuration -= timeScale / Main.TARGET_FPS;
            return;
        }
        if (currentSpell != null)
        {
            if (currentSpell.preCasting)
            {
                return;
            }
            else if (currentSpell.casting)
            {
                lockPosition = false;
                animation.lockAnimation = true;
            }
            else if (!currentSpell.casting)
            {
                currentSpell = null;
                animation.lockAnimation = false;
            }
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
        if (currentSpell == null)
        {
            if (Input.getJump(playerID) && canSuperJump) // Jump
            {
                (currentSpell = jumpSpell).begin();
                canSuperJump = false;
            }
            if (Input.getCast(playerID)) // Attack
            {
                if (grounded)
                {
                    lockPosition = true;
                    (currentSpell = attackGroundSpell).begin();
                }
                else 
                {
                    (currentSpell = attackAirSpell).begin();
                }
            }
        }
    }

    override function fixedUpdate(timeScale:Float)
    {
        canSuperJump = canSuperJump || (grounded && currentSpell == null);
    }

    override function onTilemapCollide()
    {
        stunDuration = 0;
    }

    override function onCollide(collider:Entity)
    {
        if (stunDuration > 0 || invincibilityDuration > 0)
        {
            return;
        }
        super.onCollide(collider);
        if ((collider is BaseEnemy))
        {
            takeDamage((cast(collider, BaseEnemy)).damage);
            onHit(collider);
        }
    }
    
    override function onHit(entity:Entity)
    {
        super.onHit(entity);
        var dir = new Vector((entity.pos - pos).xVector.normalized.x, (entity.pos - pos).yVector.normalized.y).normalized;
        if (dir.y == 0)
        {
            dir.y = 1;
        }
        velocity = dir * -knockbackForce;
        if (currentSpell != null)
        {
            currentSpell.cancel();
            currentSpell = null;
        }
        lockPosition = animation.lockAnimation = false;
        stunDuration = STUN_TIME;
        animation.play("Hit");
    }

    override function destroy() {
        super.destroy();
        if (!players.filter(f -> f == this).isEmpty())
        {
            players.remove(this);
            if (players.isEmpty())
            {
                LDtkController.loadLevel(0);
            }
        }
    }
}