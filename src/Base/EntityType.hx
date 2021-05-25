enum abstract EntityType(Int) to Int from Int
{
    var None = 0x0;
    var Player = 0x1;
    var Enemy = 0x2;
    var Projectile = 0x4;
}