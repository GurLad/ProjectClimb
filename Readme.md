# Project Climb
This was a challenge for me: make a complete game from scratch in exactly 1 month (release date: 20/6/21) while learning a new language (Haxe). The project is now complete.
## About
You both play the mage Blunk (I didn't have time for a second character): a huge eyeball that hates snails. Choose one of the four types of magic to use, fight snails, and reach the mighty boss at the top (spoiler: a snail).
## On Blink (teleport) and Spells
I didn't have time for an in-game tutorial, so this is how they work:

To Blink, press the Blink button and hold a direction (left, top-right, etc.) while the animation starts. Blunk can teleport through enemies (although they may still get hurt), but not through walls.

All Spells have two forms: air attack and ground attack. You can only cast the ground form while on the ground, and the air form in the air. All spells require a short amount of time (~0.2 seconds) to charge, and with you get hit during that time, the spell is cancelled.
### Spell list
 - **Fire - high damage, low range.**
   - Ground: a fast fireball. Deals 2 damage.
   - Air: a small explosion that follows the player for ~0.4 seconds. Deals 2 damage.
 - **Water - low damage, high range.**
   - Ground: three small waterballs. Deals 1 damage.
   - Air: eight small waterballs in all directions. Deals 1 damage.
 - **Air - fast moves, low range.**
   - Ground: a small, stationary shockwave that last for ~0.4 seconds and knocks back the user. Deals 2 damage.
   - Air: a small, stationary shockwave that last for ~0.4 seconds and gives a small vertical boost to the user. Deals 2 damage.
 - **Earth - slow moves, high range.**
   - Ground: a rolling stone that falls down gaps. Deals 2 damage.
   - Air: turns the user into a damaging statue, locking movement and giving a small vertical boost to the user if they land on an enemy. Deals 1 damage.
## Original README
Co-op platformer. Goal: make a complete game from scratch in exactly 1 month (release date: 20/6/21) while learning a new language (Haxe).
### Controls (partially rebindable)
 - Player 1: Move with arrows. Hop with up. Attack (magic) with numpad 4. Super Jump (teleport) with numpad 8.
 - Player 2: Move with AD. Hop with W. Attack (magic) with G. Super Jump (teleport) with H.
### TODO (last updated 20/6/21)
 - ~~Make a basic 2D engine (because I'm a masochist)~~ (done)
 - ~~Make basic platformer controls + physics (both players)~~ (done)
 - ~~Add LDtk support~~ (done)
 - ~~Add enemies~~ (done (2 + boss))
 - ~~Add all controls~~ (done)
 - ~~Add character+magic select~~ (magic select (with 4 magic types) done)
 - Add levels
 - ~~Add menu + UI~~ (done)
